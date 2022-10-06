namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    operation SetQubitState(desired : Result, target : Qubit) : Unit {

        if desired != M(target) {
            X(target);
        }
    }

   operation TestBellState(count : Int, initial : Result) : (Int, Int, Int, Int) {

        mutable numOnesQ1 = 0;
        mutable numOnesQ2 = 0;

        // allocate the qubits
        use (q1, q2) = (Qubit(), Qubit());   
        for test in 1..count {
            SetQubitState(initial, q1);
            SetQubitState(Zero, q2);
        
            // measure each qubit
            let resultQ1 = M(q1);            
            let resultQ2 = M(q2);           

            // Count the number of 'Ones':
            if resultQ1 == One {
                set numOnesQ1 += 1;
            }
            if resultQ2 == One {
                set numOnesQ2 += 1;
            }
        }

        // reset the qubits
        SetQubitState(Zero, q1);             
        SetQubitState(Zero, q2);
    

        // Return number of |0> states, number of |1> states
        Message("q1:Zero, One  q2:Zero, One");
        return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2 );
   }

   operation Teleport(message: Qubit, target: Qubit) : Unit {

       
        use register = Qubit[1];

        let here = register[0];

        // Create intranglement for send our message
        H(here);
        CNOT(here, target);

        // Move message into the intranglement pair
        CNOT(message, here);
        H(message);

        // Measure dthe etranglement
        if (M(message) == One) { Z(target); }
        if (M(here) == One) { X(target); }

        // Reset here
        Reset(here);    
              
   }

   operation TeleportClassicalMessage(message : Bool) : Bool {

           mutable measure = false;

           use registers = Qubit[2];

           // Qubit using for teleport
           let msg = registers[0];
           let target = registers[1];

           // Encding the message to send
           if (message) { X(msg); }

           Teleport(msg, target);

           if(M(target) == One) { set measure = true; }

           ResetAll(registers);

           return measure;
   }


}
