import 'package:descusion_app_fairebase/Screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/mybuton.dart';

class SignInScreen extends StatefulWidget {
  static const String screenroute = 'SignInScreen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: 150,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 40,
              width: 350,
              child: TextField(
                onChanged: (valeur) {
                  email = valeur;
                },
                decoration: const InputDecoration(
                  hintText: 'Email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 40,
              width: 350,
              child: TextField(
                onChanged: (valeur) {
                  password = valeur;
                },
                decoration: const InputDecoration(
                  hintText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Mybuton(
                  color: Colors.orange,
                  onPressed: () async {
                    // print("email:$email");
                    // print("password:$password");
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.screenroute);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: 'Sing in'),
            )
          ],
        ),
      ),
    );
  }
}
