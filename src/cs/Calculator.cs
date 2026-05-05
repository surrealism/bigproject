using System;

namespace CalculatorApp
{
    class Calculator
    {
        public double Add(double a, double b) => a + b;
        public double Subtract(double a, double b) => a - b;
        public double Multiply(double a, double b) => a * b;
        public double Divide(double a, double b)
        {
            if (b == 0) throw new DivideByZeroException("Cannot divide by zero.");
            return a / b;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            var calc = new Calculator();

            Console.WriteLine("=== C# Calculator ===");
            Console.WriteLine("1. Add  2. Subtract  3. Multiply  4. Divide");

            Console.Write("Select operation (1-4): ");
            string op = Console.ReadLine();

            Console.Write("Enter first number: ");
            double a = double.Parse(Console.ReadLine()!);

            Console.Write("Enter second number: ");
            double b = double.Parse(Console.ReadLine()!);

            try
            {
                double result = op switch
                {
                    "1" => calc.Add(a, b),
                    "2" => calc.Subtract(a, b),
                    "3" => calc.Multiply(a, b),
                    "4" => calc.Divide(a, b),
                    _ => throw new InvalidOperationException("Invalid operation.")
                };
                Console.WriteLine($"Result: {result}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
        }
    }
}
