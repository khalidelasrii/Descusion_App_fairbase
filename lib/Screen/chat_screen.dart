import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String screenroute = 'ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                height: 35,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'DiscusionApp',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: Colors.white70,
        body: Column(children: [
          Expanded(child: Container()),
          Container(
            height: 80,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.blue,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(
                    top: BorderSide(
                  color: Colors.orange,
                  width: 2,
                ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                      onChanged: (valeur) {},
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'ecrire un message....',
                          border: InputBorder.none)),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}