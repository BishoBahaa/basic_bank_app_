import 'package:basic_banking_app/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicBank());
}

class BasicBank extends StatelessWidget {
  const BasicBank({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}