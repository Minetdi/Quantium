using System;
using System.Globalization;
using System.Collections.Generic;
//using System.Linq;
using System.Threading.Tasks;
using static System.Diagnostics.Debug;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation;
using Quantum.QuantumLib;

namespace Quantum.QuantumEffect
{
    public class GraphColoring
    {

        async Task displayColorQuantumDetails(QuantumSimulator sim, String args1, String args2)
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
}
