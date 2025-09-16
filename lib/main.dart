import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "=") {
        try {
          final exp = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final evalResult = evaluator.eval(exp, {});
          _result = evalResult.toString();
          _expression = "$_expression = $_result";
        } catch (e) {
          _result = "Error";
        }
      } else {
        if (_expression.contains("=")) {
          // If previous calculation finished, start fresh
          _expression = "";
          _result = "";
        }
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blueGrey[800],
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Ekam Grewal Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(
                        fontSize: 28, color: Colors.white70),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _result,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),

          // Buttons
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
        children: [
          _buildButton("0"),
          _buildButton("%", color: Colors.orange), // ✅ added modulo
          _buildButton("C", color: Colors.red),
          _buildButton("=", color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
