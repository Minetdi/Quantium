namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    //open Quantum.QuantumLib;



    operation MarkColorEquality(c0 : Qubit[], c1 : Qubit[], target : Qubit) : Unit is Adj+Ctl {

        within {

            for (q0, q1) in Zipped(c0, c1) {
            // Compute XOR of bits q0 and q1 in place (storing it in q1).
                CNOT(q0, q1);
            }
        } apply {
            // If all computed XORs are 0, the bit strings are equal - flip the state of the target.
            (ControlledOnInt(0, X))(c1, target);
        }
    }

    operation MarkValidVertexColoring(edges : (Int, Int)[], colorsRegister : Qubit[], target : Qubit) : Unit is Adj+Ctl {

        let nbEdges = Length(edges);
        // Split the register that encodes the colors into an array of two-qubit registers,
        let colors = Chunks(2, colorsRegister);

        // Allocate one extra qubit per edge to mark the edges that connect vertices with the same color.
        use conflictQubits = Qubit[nbEdges];

        within {

            for ((start, end), conflictQubit) in Zipped(edges, conflictQubits) {
                // Check that the endpoints have different colors: apply MarkColorEquality operation; 
                // if the colors are the same, the result will be 1, indicating a conflict.
                MarkColorEquality(colors[start], colors[end], conflictQubit);
            }
        } apply {
            // If there are no conflicts (all qubits are in 0 state), the vertex coloring is valid.
            (ControlledOnInt(0, X))(conflictQubits, target);
        }
    }


    operation MakingOracleAsPhaseOracle(
        oracle : ((Qubit[], Qubit) => Unit is Adj),
        register : Qubit[]
    ) : Unit is Adj {

        use target = Qubit();

        within {
            // Put the target qubit into the |-⟩ state.
            X(target);
            H(target);
        } apply {

            oracle(register, target);
        }
    }

    operation MakingOracleAsPhaseOracle2(
        oracle : ((Qubit[], Qubit[], Qubit) => Unit is Adj),
        c0 : Qubit[],
        c1 : Qubit[]
    ) : Unit is Adj {

        use target = Qubit();

        within {
            // Put the target qubit into the |-⟩ state.
            X(target);
            H(target);
        } apply {

            oracle(c0, c1, target);
        }
    }

    //@EntryPoint()
    operation showPhaseKickbackTrick() : Unit {

        use (c0, c1) = (Qubit[2], Qubit[2]);

        ApplyToEach(H, c1);


        Message("The starting state of qubits c1:");
        DumpRegister((), c1);
        // Compare registers and mark the result in their phase.
        MakingOracleAsPhaseOracle2(MarkColorEquality, c0, c1);

        Message("");
        Message("The state of qubits c1 after the equality check:");
        DumpRegister((), c1);

        ResetAll(c1);
    }

    operation showPhaseKickbackTrick2(c0 : Qubit[], c1 : Qubit[]) : Unit {

        //use (c0, c1) = (Qubit[2], Qubit[2]);

        ApplyToEach(H, c1);


        Message("The starting state of qubits c1:");
        DumpRegister((), c1);
        // Compare registers and mark the result in their phase.
        MakingOracleAsPhaseOracle2(MarkColorEquality, c0, c1);

        Message("");
        Message("The state of qubits c1 after the equality check:");
        DumpRegister((), c1);

        ResetAll(c1);
    }

    //@EntryPoint()
    operation ShowColorEqualityCheck() : Unit {
        // Leave register c0 in the |00⟩ state.
        use (c0, c1, target) = (Qubit[2], Qubit[2], Qubit());

        // Prepare a quantum state that is a superposition of all possible colors on register c1.
        ApplyToEach(H, c1);

        // Output the initial state of qubits c1 and target. 
        Message("The starting state of qubits c1 and target:");
        DumpRegister((), c1 + [target]);

        // Compare registers and mark the result in target qubit.
        MarkColorEquality(c0, c1, target);

        Message("");
        Message("The state of qubits c1 and target after the equality check:");
        DumpRegister((), c1 + [target]);

        // Compare registers and mark the result in target qubit.
        MarkColorEquality(c1, c0, target);

        Message("");
        Message("The state of qubits c1 and target after the equality check:");
        DumpRegister((), c1 + [target]);


        // Return the qubits to |0⟩ state before releasing them.
        ResetAll(c1 + [target]);
    }




    //@EntryPoint()
    operation ShowColoringValidationCheck(edges : (Int, Int)[], nVertices: Int) : Unit {
        // Graph description: hardcoded from the example
        //let nVertices = 5;
        //let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        // Graph coloring: hardcoded from the example
        let coloring = [false, false, true, false, false, true, true, true, false, true];

        use (coloringRegister, target) = (Qubit[2 * nVertices], Qubit());
        // Encode the coloring in the quantum register:
        // apply an X gate to each qubit that corresponds to "true" bit in the bit string.
        ApplyPauliFromBitString(PauliX, true, coloring, coloringRegister);

        // Apply the operation that will check whether the coloring is valid.
        MarkValidVertexColoring(edges, coloringRegister, target);

        // Print validation result.
        let isColoringValid = M(target) == One;
        Message($"The coloring is {isColoringValid ? "valid" | "invalid"}");

        // Return the qubits to |0⟩ state before releasing them.
        ResetAll(coloringRegister);
    }
   
}