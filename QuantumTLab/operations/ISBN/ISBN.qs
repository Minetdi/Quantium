namespace Quantum.QuantumLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;
    //open quantumLib.operations;

    operation ISBN () : Unit {
        
    }

    // Ops
    operation init(qubit : Qubit) : Unit is Adj + Ctl {

        X(qubit);
        H(qubit);
    }

    // Réflexion sur la superposition uniforme
    operation PrepareISBNSuperpositionOverDigits(digitReg : Qubit[]) : Unit is Adj + Ctl {
        PrepareUniformSuperpositionOverDigits(digitReg, 10, 1.0, 0.0);
    }

    // Détermine le nombre d' intérations de 


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


    // Vérifie si l'ISBN est valide ou non
    function IsIsbnValid(digits : Int[]) : Bool {
        // ensure array is 10 digits
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");

        mutable acc = 0;
        for (idx, digit) in Enumerated(digits) {
            set acc += (10 - idx) * digit;
        }
        return acc % 11 == 0;
    }

    // Reconstruit les chiffres perdues 
    function MakeResultISBN(missingDigit : Int, inputISBN : Int[]) : Int[] {
        mutable resultISBN = [0, size=Length(inputISBN)];
        for i in 0..Length(inputISBN) - 1 {
            if inputISBN[i] < 0 {
                set resultISBN w/= i <- missingDigit;
            }
            else {
                set resultISBN w/= i <- inputISBN[i];
            }
        }
        return resultISBN;
    }

    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            // Transform the uniform superposition to all-zero.
            Adjoint PrepareISBNSuperpositionOverDigits(digitReg);
            // Transform the all-zero state to all-ones
            ApplyToEachCA(X, digitReg);
        } apply {
            // Reflects about that all-ones state, then let the within/apply
            // block transform the state back to the initial basis.
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }

    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        PrepareISBNSuperpositionOverDigits(register);
        for _ in 1 .. iterations {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }
}
