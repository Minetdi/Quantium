namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic; 
    open Microsoft.Quantum.Arrays; 
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;
    //open Quantum.QuantumLib;

       //@ Microsoft.Quantum.Core.Attribute()
    //newtype EntryPoint = (Unit);

    //@EntryPoint()
    operation SearchForMissingDigit() : Unit {

        // define the incomplete ISBN, missing digit at -1
        let inputISBN = [0, 3, 0, 6, -1, 0, 6, 1, 5, 2];
        let constants = GetISBNConstant(inputISBN);
        let (a, b) = constants;

        Message($"ISBN with missing digit: {inputISBN}");
        Message($"Oracle validates: ({b} + {a}x) mod 11 = 0 \n");

        // get the number of Grover iterations required for 10 possible results and 1 solution
        let numIterations = NIterations(10);

        // Define the oracle
        let phaseOracle = ISBNOracle(_, constants);

        // Allocate 4-qubit register necessary to represent the possible values (digits 0-9)
        use digitReg = Qubit[4];
        mutable missingDigit = 0;
        mutable resultISBN = [10];
        mutable attempts = 0;

        // Repeat the algorithm until the result forms a valid ISBN
        repeat{
            RunGroversSearch(digitReg, phaseOracle, numIterations);
            // print the resulting state of the system and then measure
            DumpMachine(); 
            set missingDigit = MeasureInteger(LittleEndian(digitReg));
            set resultISBN = MakeResultISBN(missingDigit, inputISBN);
            // keep track of the number of attempts
            set attempts = attempts  + 1;
        } 
        until IsIsbnValid(resultISBN);

        // print the results
        Message($"Missing digit: {missingDigit}");
        Message($"Full ISBN: {resultISBN}");
        if attempts == 1 {
            Message($"The missing digit was found in {attempts} attempt.");
        }
        else {
            Message( $"The missing digit was found in {attempts} attempts.");
        }
    }
}
