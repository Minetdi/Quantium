namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
  

    operation GroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        ApplyToEach(H, register);
        
        for _ in 1 .. iterations {
            phaseOracle(register);
            within {
                ApplyToEachA(H, register);
                ApplyToEachA(X, register);
            } apply {
                Controlled Z(Most(register), Tail(register));
            }
        }
    }

    // Détermine le nombre d'itérations
    function NIterations(nItems : Int) : Int {
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }

}