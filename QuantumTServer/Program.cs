using System;
using System.Globalization;
using System.Collections.Generic;
//using System.Linq;
using System.Threading.Tasks;
using static System.Diagnostics.Debug;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
//using QuantumTServer.Services;
using Microsoft.Quantum.Simulation;
using Quantum.QuantumLib;


namespace Quantum.QuantumEffect
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

                    //var teleport = TeleportClassicalMessage.Run(sim, sent).Result;
                    //var receivingInt = TeleportMessage.Run(sim, sendingInt).Result;
                    //var receiveString = TeleportStringMessage.Run(sim, "Yes").Result;
                    //var ft = QFT.Run(sim, 2).Result;

                    await displayColorQuantumDetails(sim, args[1], args[0]);

                    //Console.WriteLine("Round" + arg + ": \nSent " + sendingInt + ", \tgot:" + receivingInt);
                    //Console.WriteLine("Round" + arg + ": \nSent " + "Yes" + ", \tgot:" + receiveString);

                    //Console.WriteLine("result: \n" + res);
                    //Console.WriteLine(receivingInt);
                    //Console.WriteLine(sent == teleport ? "Teleportation Sucessfull!! \n" : "\n");
                }

                //(Int64, Int64)[] edges = new (Int64, Int64)[] { (0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4) };

                //int nVertices = 5;
                //(Int64, Int64)[] edges = { (0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4) };

                //List<(long, long)> edges = new List<(long, long)>();
                //long nVertices = Convert.ToInt64(args[0]);
                //List<int> nums = new List<int>();

                //while (args[1] != null)
                //{
                //    string ver = Console.ReadLine();
                //    char[] delimiterChars = { '(', ')', ',', ' ', '-', '\t' };


                //    string[] words = args[1].Split(delimiterChars);
                //    System.Console.WriteLine($"{words.Length} words in text:");
                //    //(int, int)[] edges = new (int,int);

                //    foreach (var word in words)
                //    {
                //        string[] vertexes = word.Split(delimiterChars);
                //        foreach (var vertex in vertexes)
                //        {

                //            foreach (String num in vertex.Split('>'))
                //            {
                //                if (num != "")
                //                    if (int.TryParse(num, System.Globalization.NumberStyles.Number, null, out int i))
                //                    {
                //                        nums.Add(i);
                //                    }
                //            }


                //        }
                //    }

                //    edges = make_pair(nums);
                //    var qarray = new QArray<(long, long)>();
                //    (long, long)[] ed = make_pair(nums).ToArray();

                //    foreach ((int, int) e in ed)
                //    {

                //        System.Console.WriteLine(e);
                //        qarray = new QArray<(long, long)>(ed);

                //    }
                //    await SolveGraphColoringProblem.Run(sim, qarray, nVertices);

                //    //var qarray = new QArray<(long, long)>(ed);
                //    //SolveGraphColoringProblem.Run(sim, qarray, nVertices);

                //}


                int[] terms = new int[400];

                //var qarray = new QArray<(long, long)>(edges);
                //await SolveGraphColoringProblem.Run(sim, qarray, nVertices);
                //int[] marks = new int[5] { 99, 98, 92, 97, 95 };

                Int64[] numbers = new Int64[10] { 1, 3, 4, 9, 4, 13, 6, 19, 8, 2 };
                //var constant = await GetISBNConstant.Run(sim, new QArray<long>(numbers));
                //Console.WriteLine("\n\n");

                //Console.WriteLine("result: " + constant);

                //Console.WriteLine("Colors simul: \n" + simulateColor);
                System.Console.WriteLine("\n\n Press Enter to exit ...\n\n");
                System.Console.ReadLine();

            }
        }

        static async Task displayColorQuantumDetails(QuantumSimulator sim, String args1, String args2)
        {
            List<(long, long)> edges = new List<(long, long)>();
            long nVertices = Convert.ToInt64(args2);
            List<int> nums = new List<int>();

            while (args1 != null)
            {
                string ver = Console.ReadLine();
                char[] delimiterChars = { '(', ')', ',', ' ', '-', '\t' };


                string[] words = args1.Split(delimiterChars);
                System.Console.WriteLine($"{words.Length} words in text:");
                //(int, int)[] edges = new (int,int);

                foreach (var word in words)
                {
                    string[] vertexes = word.Split(delimiterChars);
                    foreach (var vertex in vertexes)
                    {

                        foreach (String num in vertex.Split('>'))
                        {
                            if (num != "")
                                if (int.TryParse(num, System.Globalization.NumberStyles.Number, null, out int i))
                                {
                                    nums.Add(i);
                                }
                        }
                    }
                }

                edges = make_pair(nums);
                var qarray = new QArray<(long, long)>();
                (long, long)[] ed = make_pair(nums).ToArray();

                foreach ((int, int) e in ed)
                {

                    System.Console.WriteLine(e);
                    qarray = new QArray<(long, long)>(ed);

                }
                await SolveGraphColoringProblem.Run(sim, qarray, nVertices);

                //var qarray = new QArray<(long, long)>(ed);
                //SolveGraphColoringProblem.Run(sim, qarray, nVertices);

            }

        }

        static public List<(long, long)> make_pair(List<int> array)
        {
            List<(long, long)> result = new List<(long, long)>(array.Count);

            for (int i = 0; i < array.Count; i++)
            {
                result.Add((array[i], array[i + 1]));
                i++;
            }
            return result;
        }
    }


    //public static uint[] GetIds(this Microsoft.Quantum.Simulation.Core.IQArray<Microsoft.Quantum.Simulation.Core.Qubit> qubits);

}
