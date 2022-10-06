using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static System.Diagnostics.Debug;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
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
                _ = SolveGraphColoringProblem.Run(sim).Result;
                //Console.WriteLine("\n\n");
                //_ = ShowColorEqualityCheck.Run(sim).Result;
                //Console.WriteLine("\n\n");
                //_ = ShowColoringValidationCheck.Run(sim).Result;
                //Console.WriteLine("\n\n");
                //_ = showPhaseKickbackTrick.Run(sim).Result;

                //Console.WriteLine("result: \n" + res);

                //Console.WriteLine("Colors simul: \n" + simulateColor);
                System.Console.WriteLine("\n\n Press Enter to exit ...\n\n");
                System.Console.ReadLine();

            }
        }

    }

}