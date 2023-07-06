import 'package:flutter/material.dart';

import 'Screen/regestration_screen.dart';
import 'Screen/welcom_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descusion App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: RegestrationScreen(),
    );
  }
}
