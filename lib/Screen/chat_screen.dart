import 'package:descusion_app_fairebase/Screen/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String screenroute = 'ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream()async{
   await for(var snapshot in  _firestore.collection('messages').snapshots()){
    for(var message in snapshot.docs){
      print(message.data());
    } 
   }
  }

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
                onPressed: () {
                  messagesStream();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: Colors.white70,
        body: Column(children: [
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').snapshots(),
            builder: (context, snapshot) {
              List<Text> messageWidgets = [];
              if(!snapshot.hasData){
return const Center(child: CircularProgressIndicator(backgroundColor: Colors.amber),) ;             }
              final messages = snapshot.data!.docs;
              for(var message in messages){
                final messageText = message.get('text');
                final messageSender = message.get('sender');
                final messageWidget = Text('$messageText - $messageSender');
                messageWidgets.add(messageWidget);
              }
              return Expanded(child: ListView(children: messageWidgets,));
            },
          )),
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
                      onChanged: (valeur) {
                        messageText = valeur;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'ecrire un message....',
                          border: InputBorder.none)),
                ),
                TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': signedInUser.email});
                    },
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
