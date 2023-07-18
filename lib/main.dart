import 'package:descusion_app_fairebase/Screen/regestration_screen.dart';
import 'package:descusion_app_fairebase/Screen/welcom_screen.dart';
import 'package:flutter/material.dart';

import 'Screen/chat_screen.dart';
import 'Screen/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descusion App',
      theme: ThemeData(
        primarySwatch:  Colors.green,
      ),
      debugShowCheckedModeBanner: false,
       
      initialRoute:_auth.currentUser != null ? ChatScreen.screenroute :WelcomScreen.screenRout,
      routes: {
        WelcomScreen.screenRout: (context) => WelcomScreen(),
        SignInScreen.screenroute: (context) => SignInScreen(),
        RegestrationScreen.screenrout: (context) => RegestrationScreen(),
        ChatScreen.screenroute: (context) => ChatScreen(),
      },
    );
  }
}
