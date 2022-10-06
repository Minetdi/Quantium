namespace Quantum.QuantumLib {

   open Microsoft.Quantum.Measurement;
   open Microsoft.Quantum.Math;
   open Microsoft.Quantum.Arrays;
   open Microsoft.Quantum.Canon;
   open Microsoft.Quantum.Convert;
   open Microsoft.Quantum.Diagnostics;
   open Microsoft.Quantum.Intrinsic;


   // Main Test Function
   @EntryPoint()
   operation SolveGraphColoringProblem() : Unit {
        // Graph description: hardcoded from the example.
        let nVertices = 5;
        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        // Define the oracle that implements this graph coloring.
        let markingOracle = MarkValidVertexColoring(edges, _, _);
        let phaseOracle = MakingOracleAsPhaseOracle(markingOracle, _);

        // Define the parameters of the search.
        
        // Each color is described using 2 bits (or qubits).
        let nQubits = 2 * nVertices;

        // The search space is all bit strings of length nQubits.
        let searchSpaceSize = 2 ^ (nQubits);

        // The number of solutions is the number of permutations of 4 colors (over the first four vertices) = 4!
        // multiplied by 3 colors that vertex 4 can take in each case.
        let nSolutions = 72;

        // The number of iterations can be computed using a formula.
        let nIterations = Round(PI() / 4.0 * Sqrt(IntAsDouble(searchSpaceSize) / IntAsDouble(nSolutions)));

        mutable answer = [false, size=nQubits];
        use (register, output) = (Qubit[nQubits], Qubit());
        mutable isCorrect = false;
        repeat {
            GroversSearch(register, phaseOracle, nIterations);
            let res = MultiM(register);
            // Check whether the result is correct.
            markingOracle(register, output);
            if (MResetZ(output) == One) {
                set isCorrect = true;
                set answer = ResultArrayAsBoolArray(res);
            }
            ResetAll(register);
        } until (isCorrect);
        // Convert the answer to readable format (actual graph coloring).
        let colorBits = Chunks(2, answer);
        Message("The resulting graph coloring:");
        for i in 0 .. nVertices - 1 {
            Message($"Vertex {i} - color {BoolArrayAsInt(colorBits[i])}");
        }
        ShowColorEqualityCheck();
   }
}