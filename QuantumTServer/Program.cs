using System;
using System.Globalization;
using System.Collections.Generic;
//using System.Linq;
using System.Threading.Tasks;
using static System.Diagnostics.Debug;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using QuantumTServer.Services;
using Microsoft.Quantum.Simulation;
//using Quantum.QuantumLib;
//using QuantumTServer;


namespace QuantumTServer
{
    class Driver
    {
        static async Task Main(String[] args)
        {
            //if (args.Length == 0)
            //{
            //    System.Console.WriteLine("Please enter a numeric argument.");
            //    return 1;
            //}

            using (var sim = new QuantumSimulator())
            {
                var rand = new System.Random();

                foreach (var arg in Enumerable.Range(0, 8))
                {
                    var sent = rand.Next(2) == 0;
                    var sendingInt = rand.Next(2);
                    Int64[] numbers = new Int64[10] { 1, 3, 4, 9, 4, 13, 6, 19, 8, 2 };
                    //var color = new GraphColoring();

                    //var teleport = TeleportClassicalMessage.Run(sim, sent).Result;
                    //var receivingInt = TeleportMessage.Run(sim, sendingInt).Result;
                    //var receiveString = TeleportStringMessage.Run(sim, "Yes").Result;
                    //var ft = QFT.Run(sim, 2).Result;
                    try
                    {
                        //new GraphColoring().displayColorQuantumDetails(sim, args[1], args[0]);
                         await new ISBNEncrypt().displayMissingDigits(sim);
                    } catch
                    {
                        Console.WriteLine("Not Work");
                    }


                    //Console.WriteLine("Round" + arg + ": \nSent " + sendingInt + ", \tgot:" + receivingInt);
                    //Console.WriteLine("Round" + arg + ": \nSent " + "Yes" + ", \tgot:" + receiveString);

                    //Console.WriteLine("result: \n" + res);
                    //Console.WriteLine(receivingInt);
                    //Console.WriteLine(sent == teleport ? "Teleportation Sucessfull!! \n" : "\n");
                }


                int[] terms = new int[400];

                //var qarray = new QArray<(long, long)>(edges);
                //await SolveGraphColoringProblem.Run(sim, qarray, nVertices);
                //int[] marks = new int[5] { 99, 98, 92, 97, 95 };


                //var constant = await GetISBNConstant.Run(sim, new QArray<long>(numbers));
                //Console.WriteLine("\n\n");

                //Console.WriteLine("result: " + constant);

                //Console.WriteLine("Colors simul: \n" + simulateColor);
                System.Console.WriteLine("\n\n Press Enter to exit ...\n\n");
                System.Console.ReadLine();

            }
        }
    }


    //public static uint[] GetIds(this Microsoft.Quantum.Simulation.Core.IQArray<Microsoft.Quantum.Simulation.Core.Qubit> qubits);

}
