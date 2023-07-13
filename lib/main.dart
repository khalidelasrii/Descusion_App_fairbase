import 'package:descusion_app_fairebase/Screen/regestration_screen.dart';
import 'package:descusion_app_fairebase/Screen/welcom_screen.dart';
import 'package:flutter/material.dart';

import 'Screen/chat_screen.dart';
import 'Screen/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descusion App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      //home: SignInScreen(),
      initialRoute: WelcomScreen.screenRout,
      routes: {
        WelcomScreen.screenRout: (context) => WelcomScreen(),
        SignInScreen.screenroute: (context) => SignInScreen(),
        RegestrationScreen.screenrout: (context) => RegestrationScreen(),
        ChatScreen.screenroute: (context) => ChatScreen(),
      },
    );
  }
}
