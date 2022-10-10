using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static System.Diagnostics.Debug;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation;
using Quantum.QuantumLib;


namespace Quantum.QuantumEffect
{
    class Driver
    {
        static async Task Main(String[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var rand = new System.Random();

                foreach (var arg in Enumerable.Range(0, 8))
                {
                    var sent = rand.Next(2) == 0;
                    var sendingInt = rand.Next(2);

                    //var teleport = TeleportClassicalMessage.Run(sim, sent).Result;
                    //var receivingInt = TeleportMessage.Run(sim, sendingInt).Result;
                    //var receiveString = TeleportStringMessage.Run(sim, "Yes").Result;
                    //var ft = QFT.Run(sim, 2).Result;


                    //Console.WriteLine("Round" + arg + ": \nSent " + sendingInt + ", \tgot:" + receivingInt);
                    //Console.WriteLine("Round" + arg + ": \nSent " + "Yes" + ", \tgot:" + receiveString);

                    //Console.WriteLine("result: \n" + res);
                    //Console.WriteLine(receivingInt);
                    //Console.WriteLine(sent == teleport ? "Teleportation Sucessfull!! \n" : "\n");
                }

                //(Int64, Int64)[] edges = new (Int64, Int64)[] { (0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4) };

                int nVertices = 5;
                (Int64, Int64)[] edges = { (0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4) };
                var qarray = new QArray<(long, long)>(edges);
                await SolveGraphColoringProblem.Run(sim, qarray, nVertices);
                //int[] marks = new int[5] { 99, 98, 92, 97, 95 };


                // _ = SolveGraphColoringProblem.Run(sim).Result;
                //await SolveGraphColoringProblem.Run(sim, qarray, nVertices);
                Int64[] numbers = new Int64[10] { 1, 3, 4, 9, 4, 13, 6, 19, 8, 2 };
                var constant = await GetISBNConstant.Run(sim, new QArray<long>(numbers));
                //Console.WriteLine("\n\n");
                //_ = ShowColorEqualityCheck.Run(sim).Result;
                //Console.WriteLine("\n\n");
                //_ = ShowColoringValidationCheck.Run(sim).Result;
                //Console.WriteLine("\n\n");
                //_ = showPhaseKickbackTrick.Run(sim).Result;

                Console.WriteLine("result: " + constant);

                //Console.WriteLine("Colors simul: \n" + simulateColor);
                System.Console.WriteLine("\n\n Press Enter to exit ...\n\n");
                System.Console.ReadLine();

            }
        }


        //public static uint[] GetIds(this Microsoft.Quantum.Simulation.Core.IQArray<Microsoft.Quantum.Simulation.Core.Qubit> qubits);

    }

}