import 'package:flutter/material.dart';

class RegestrationScreen extends StatefulWidget {
  const RegestrationScreen({super.key});

  @override
  State<RegestrationScreen> createState() => _RegestrationScreenState();
}

class _RegestrationScreenState extends State<RegestrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: Image.asset('images/logo.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
