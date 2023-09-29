import 'package:chat/constants.dart';
import 'package:chat/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/Views/widgets/Bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message._meodel.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final controllerview = ScrollController();
  Usermodel usermodel;
  CollectionReference collectionReference;

  Usermodel myFriend;
  ChatView({
    super.key,
    required this.usermodel,
    required this.collectionReference,
    required this.myFriend,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(myFriend.stringImage!),
            ),
            const SizedBox(width: 14),
            Text(
              myFriend.name!,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            //I could use container with a specific height 'cause I need a height specific to make the listview
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List<Message> messageslist =
                    BlocProvider.of<ChatCubit>(context).messageslist;

                return ListView.builder(
                  reverse: true,
                  controller: controllerview,
                  itemCount: messageslist.length,
                  itemBuilder: (context, index) {
                    if (messageslist[index].seen) {
                      return messageslist[index].id == usermodel.phoneNumber
                          ? BubbleChat(
                              message: messageslist[index],
                              icon: const Icon(
                                Icons.done_all,
                                size: 13,
                                color: Colors.black,
                              ),
                            )
                          : BubbleChatFriend(
                              message: messageslist[index],
                              icon: const Icon(
                                Icons.done_all,
                                size: 13,
                                color: Colors.black,
                              ),
                            );
                    } else {
                      return messageslist[index].id == usermodel.phoneNumber
                          ? BubbleChat(
                              message: messageslist[index],
                              icon: const Icon(
                                Icons.done,
                                size: 13,
                                color: Colors.black,
                              ),
                            )
                          : BubbleChatFriend(
                              message: messageslist[index],
                              icon: const Icon(
                                Icons.done,
                                size: 13,
                                color: Colors.black,
                              ),
                            );
                    }
                  },
                );
              },
            ),
          ),
          TextField(
            controller: controller,
            onSubmitted: (data) async {
              await BlocProvider.of<ChatCubit>(context).sendMessage(
                  collectionReference: collectionReference,
                  message: data,
                  usermodel: usermodel);
              await BlocProvider.of<ChatCubit>(context).getMessages(
                  collectionReference: collectionReference,
                  usermodel: usermodel);

              controller.clear();
              controllerview.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
              );
            },
            decoration: InputDecoration(
              hintText: 'Send message',
              suffixIcon: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
