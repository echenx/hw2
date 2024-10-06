import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _displayText = '';
  String _first = '';
  String _second = '';
  String _operator = '';
  bool _operatorSelected = false;

  void _onPress(String value) {
    setState(() {
      if (RegExp(r'^[0-9]$').hasMatch(value)) { //check if the button pressed is a num
        if (_operatorSelected) {
          _second += value;
        } else {
          _first += value;
        }
        _displayText += value;
      } else if (RegExp(r'^[+\-*/]$').hasMatch(value) && _first.isNotEmpty) { //check if the button pressed is a operator 
        _operator = value;
        _operatorSelected = true;
        _displayText += ' $value ';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          _button(['7', '8', '9', '/']),
          _button(['4', '5', '6', '*']),
          _button(['1', '2', '3', '+']),
          _button(['0', 'C', '=', '-']), 
        ],
      ),
    );
  }

  Widget _button(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return _buildButton(value);
      }).toList(),
    );
  }

  Widget _buildButton(String value) {
    return InkWell(
      onTap: () => _onPress(value), 
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

