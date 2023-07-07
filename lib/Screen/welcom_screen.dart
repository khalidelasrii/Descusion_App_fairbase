import 'package:flutter/material.dart';

import '../Widgets/mybuton.dart';

class WelcomScreen extends StatelessWidget {
  static const String screenRout = 'WelcomScreen';
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(
                height: 150,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const Text('DiscussionApp',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff294277))),
            const SizedBox(
              height: 15,
            ),
            Mybuton(
              color: const Color.fromARGB(228, 255, 82, 2),
              title: 'Sign In',
              onPressed: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            Mybuton(
              color: const Color.fromARGB(227, 27, 96, 245),
              title: 'Sign Up',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
