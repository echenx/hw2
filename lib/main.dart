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
      if (RegExp(r'^[0-9]$').hasMatch(value)) {
        if (_operatorSelected) {
          _second += value;
        } else {
          _first += value;
        }
        _displayText += value;
      } else if (RegExp(r'^[+\-*/]$').hasMatch(value) && _first.isNotEmpty) {
        _operator = value;
        _operatorSelected = true;
        _displayText += ' $value ';
      } else if (value == '=' && _first.isNotEmpty && _second.isNotEmpty && _operator.isNotEmpty) {
        _evaluateExpression();
      } else if (value == 'C') {
        _clear();
      }
    });
  }

  void _evaluateExpression() {
    int num1 = int.parse(_first);
    int num2 = int.parse(_second);
    int result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 ~/ num2;
        } else {
          _displayText = 'Error';
          _clear();
          return;
        }
        break;
    }

    setState(() {
      _displayText = result.toString();
      _first = result.toString();
      _second = '';
      _operator = '';
      _operatorSelected = false;
    });
  }

  void _clear() {
    setState(() {
      _displayText = '';
      _first = '';
      _second = '';
      _operator = '';
      _operatorSelected = false;
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




