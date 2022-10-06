namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;
    // open Microsoft.Quantum.Math;

    operation ISBN () : Unit {
        
    }

    // Ops
    operation init(qubit : Qubit) : Unit is Adj + Ctl {

        X(qubit);
        H(qubit);
    }

    // Appliquer le mappage arithmétique à l’état cible

    operation computeISBNCheck(digitRegister : Qubit[], targetRegister : Qubit[], flag : Qubit, constants : (Int, Int)) : Unit is Adj + Ctl{

        let (a, b) = constants;

        // Initialize flag qubit to |-⟩ 
        init(flag);
        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |9⟩:
        ApplyXorInPlace(b, LittleEndian(targetRegister));

        // Apply the mapping |x⟩|9⟩ -> |x⟩ |(9 + 6*x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(a, 11, LittleEndian(digitRegister), LittleEndian(targetRegister));
    }


    // ORACLE
    // Signaler l’état correct en appliquant l’oracle
    operation ISBNOracle(digitRegister : Qubit[], constants : (Int, Int)) : Unit is Adj + Ctl {

        use (targetRegister, flag) = (Qubit[Length(digitRegister)], Qubit());

        within {
            computeISBNCheck(digitRegister, targetRegister, flag, constants);
        } apply {
            // States where targetReg is in |0⟩ number state will be flagged with a -1
            // phase due to controlled X they apply to the flag qubit in the |-⟩ state.
            ApplyControlledOnInt(0, X, targetRegister, flag);
        }
    }

    // Généraliser à des ISBN arbitraires
    // Return constant a and b of 0=(b+a⋅x)mod11
    function GetISBNConstant(digits : Int[]) : (Int, Int) {
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        // |(b + a x) mod 11 ⟩

        mutable a = 0;
        mutable b = 0;

        for (index, digit) in Enumerated(digits) {
            if digit < 0 {
                set a = 10 - index;
            } else {
                set b += (10 - index) * digit;
            }
        }

        return (a, b % 11);
    }
}
