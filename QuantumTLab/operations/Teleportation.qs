namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Quantum.QuantumLib;


    //@EntryPoint()
    //operation HelloQ() : Unit {
    //    Message("Hello quantum world!");
    //}
    operation SWAP (q1 : Qubit, q2 : Qubit) : Unit is Adj + Ctl { 

        body (...) {
            CNOT(q1, q2);
            CNOT(q2, q1);
            CNOT(q1, q2);
        }

        adjoint (...) { 
            SWAP(q1, q2);
        }

        controlled (cs, ...) { 
            CNOT(q1, q2);
            Controlled CNOT(cs, (q2, q1));
            CNOT(q1, q2);            
        } 
    }

    operation TeleportMessage(message : Int) : Int {

        mutable measure = 0;

        use registers = Qubit[2];

        // Qubit using for teleport
        let msg = registers[0];
        let target = registers[1];

        // Encding the message to send
        if (message == 1) { X(msg); }

        Teleport(msg, target);

        if(M(target) == One) { 
            set measure = measure + 1; 
        }

        ResetAll(registers);

        return measure;
    }

    operation TeleportStringMessage(message : String) : String {

        mutable measure = "";

        use registers = Qubit[2];

        // Qubit using for teleport
        let msg = registers[0];
        let target = registers[1];

        // Encding the message to send
        if (message == "Yes") { X(msg); }

        Teleport(msg, target);

        if(M(target) == One) { 
            set measure = message; 
        }

        ResetAll(registers);

        return measure;
    }
}