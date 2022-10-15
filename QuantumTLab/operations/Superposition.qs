namespace Quantum.QuantumLib  {

    open Microsoft.Quantum.Canon; // ApplyControlledOnInt, ApplyToEachCA
    open Microsoft.Quantum.Intrinsic; // X, H, Z
    open Microsoft.Quantum.Arithmetic; // ApplyXorInPlace, MultiplyAndAddByModularInteger, LittleEndian, MeasureInteger
    open Microsoft.Quantum.Arrays; // ConstantArray, Most, Tail, Enumerated
    open Microsoft.Quantum.Convert; // IntAsDouble
    open Microsoft.Quantum.Math; // ArcSin, Sqrt, Round, PI, ComplexPolar
    open Microsoft.Quantum.Preparation; // PrepareArbitraryStateCP
    open Microsoft.Quantum.Diagnostics; // EqualityFactI, DumpMachine

    operation Superposition () : Unit {
        
    }

    operation PrepareUniformSuperpositionOverDigits(digitReg : Qubit[], length: Int, magnitude: Double, argument : Double) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(length, ComplexPolar(magnitude, argument)), LittleEndian(digitReg));
    }

    //@EntryPoint()
    operation GenerateRandomBit() : Result {
        use q = Qubit();
        Message("Initialized qubit:");
        DumpMachine();
        Message(" ");
        H(q);
        Message("Qubit after applying H:");
        DumpMachine();
        Message(" ");
        let randomBit = M(q);
        Message("Qubit after the measurement:");
        DumpMachine();
        Message(" ");
        Reset(q);
        Message("Qubit after resetting:");
        DumpMachine();
        Message(" ");
        return randomBit;
    }
}