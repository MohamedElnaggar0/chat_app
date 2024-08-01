import 'package:flutter/material.dart';
import 'package:scholar_chat/constractor.dart';
import 'package:scholar_chat/model/message_model.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/chat_buble_for_friend.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  static String id = 'chatPage';

  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessage);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreateAt, descending: true).snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(kLogo),
                    height: 60,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messageList.length,
                    itemBuilder: ((context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(
                              message: messageList[index],
                            )
                          : ChatBubleForFriend(message: messageList[index]);
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (date) {
                      messages.add({
                        kMessage: date,
                        kCreateAt: DateTime.now(),
                        'id': email
                      });

                      _scrollController.animateTo(
                        0,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 500),
                      );

                      controller.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
                child: Text(
              'Loading.....',
              style: TextStyle(fontSize: 60),
            )),
          );
        }
      }),
    );
  }
}
