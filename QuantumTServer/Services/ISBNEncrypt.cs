using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Quantum.QuantumLib;

namespace QuantumTServer.Services
{
    public class ISBNEncrypt
    {
        QuantumSimulator sim = new QuantumSimulator();

        public ISBNEncrypt()
        {
            
        }

        public async Task displayMissingDigits(QuantumSimulator sim)
        {

             await SearchForMissingDigit.Run(sim);

        }

        public async void displayConstant(Int64[] numbers)
        {
            var constant = await GetISBNConstant.Run(sim, new QArray<long>(numbers));
            Console.WriteLine("result: " + constant);
        }
    }
}
