import 'package:chat/constants.dart';
import 'package:chat/Cubits/Usertile_cubit/user_tile_cubit.dart';
import 'package:chat/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat/models/User_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_view.dart';

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  UserTile({required this.myFreind, required this.usermodel});
  final Usermodel myFreind;
  final Usermodel usermodel;
  CollectionReference? collectionReference;
  bool istarget = false;

  @override
  Widget build(BuildContext context) {
    collectionReference = BlocProvider.of<ChatCubit>(context)
        .identifyCollection(
            usermodel: usermodel, myFriendphonenumber: myFreind.phoneNumber!);
    return GestureDetector(
      onTap: () async {
        istarget = true;
        await BlocProvider.of<UserTileCubit>(context).moveToChat(
            context: context,
            usermodel: usermodel,
            collectionReference: collectionReference!);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatView(
            usermodel: usermodel,
            collectionReference: collectionReference!,
            myFriend: myFreind,
          );
        }));
      },
      child: BlocBuilder<UserTileCubit, UserTileState>(
        builder: (context, state) {
          if (state is UserTileLoading && istarget) {
            istarget = false;
            return Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      usermodel.stringImage == null
                          ? const CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA9j-C3_YS7NAVZT4572tFatGX80YHRePaPNUnbLmlRWrSPgeqbeaj1mMd0F5IgW_G8_A&usqp=CAU'),
                            )
                          : CircleAvatar(
                              radius: 32,
                              backgroundImage:
                                  NetworkImage(myFreind.stringImage!),
                            ),
                      const SizedBox(width: 18),
                      SizedBox(
                        width: 240,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              myFreind.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              myFreind.bio!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.message,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
