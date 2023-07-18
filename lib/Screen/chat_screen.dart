import 'package:descusion_app_fairebase/Screen/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
  



  final _firestore = FirebaseFirestore.instance;
  late User signedInUser;


class ChatScreen extends StatefulWidget {
  static const String screenroute = 'ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? messageText;
  final textEditingController = TextEditingController();

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
                  _auth.signOut(); 
                  Navigator.pushNamed(context, WelcomScreen.screenRout);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: Colors.white70,
        body: Column(children: [
          const Expanded(child:MessageStreamBuilder() ),
          Container(
            height: 80,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                border: Border(
                    top: BorderSide(
                  color: Colors.green,
                  width: 2,
                ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
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
                      textEditingController.clear();
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': signedInUser.email,'time':FieldValue.serverTimestamp()});
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

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').orderBy('time').snapshots(),
            builder: (context, snapshot) {
              List<MessageView> messageWidgets = [];
              if(!snapshot.hasData){
return const Center(child: CircularProgressIndicator(backgroundColor: Colors.amber),) ;             }
              final messages = snapshot.data!.docs;
              for(var message in messages){
                final messageText = message.get('text');
                final messageSender = message.get('sender');
                final currentUser = signedInUser.email;
                final messageWidget = MessageView(sender: messageSender,text: messageText,isMe:currentUser ==messageSender ,);
                messageWidgets.add(messageWidget);
              }
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 9),child: Expanded(child: ListView(children: messageWidgets,)));
            },
          );
  }
}

class MessageView  extends StatelessWidget {
  const MessageView ({super.key,  
     this.text, this.sender,required this.isMe});
  final String? text;
  final String? sender;
  final bool isMe; 
  
  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: 

      Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children:[
          Text('$sender',style: const TextStyle(fontSize: 10,color: Color.fromARGB(255, 7, 87, 153)),),
          Material(
          borderRadius: isMe ?
          const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft:Radius.circular(20),
          bottomRight: Radius.circular(20),) : const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft:Radius.circular(20),
          bottomRight: Radius.circular(20),),
          color: isMe ? Colors.green.shade600 : Colors.blue.shade300 ,
          elevation: 6,
          child:Padding(padding: const EdgeInsets.all(8),child: Text('$text ',style: const TextStyle(fontSize: 16,color: Colors.white),)),
             ),] 
      ),);
  }
}