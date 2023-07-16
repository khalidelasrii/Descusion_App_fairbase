import 'package:descusion_app_fairebase/Screen/chat_screen.dart';
import 'package:descusion_app_fairebase/Widgets/mybuton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegestrationScreen extends StatefulWidget {
  static const String screenrout = 'RegestrationScreen';
  const RegestrationScreen({super.key});

  @override
  State<RegestrationScreen> createState() => _RegestrationScreenState();
}

class _RegestrationScreenState extends State<RegestrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
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
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Mybuton(
                    color: Colors.blue,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        Navigator.pushNamed(context, ChatScreen.screenroute);
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    title: 'Sing Up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
