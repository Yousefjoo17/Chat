import 'package:chat/Views/Edit_profile_View.dart';
import 'package:chat/Views/Welcome_view.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/Views/widgets/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.usermodel});
  static String id = 'HomePage';
  final Usermodel usermodel;
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(kUsersCollection);

    return StreamBuilder(
      stream: users.orderBy(kcreatedAt).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Usermodel> myUsers = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (usermodel.phoneNumber != snapshot.data!.docs[i][kPhoneNumber]) {
              myUsers.add(Usermodel(
                phoneNumber: snapshot.data!.docs[i][kPhoneNumber],
                name: snapshot.data!.docs[i][kName],
                email: snapshot.data!.docs[i][kEmail],
                bio: snapshot.data!.docs[i][kBio],
                stringImage: snapshot.data!.docs[i][kImage],
                docID: snapshot.data!.docs[i][kDocID],
              ));
            } else {
              usermodel.stringImage = snapshot.data!.docs[i][kImage];
              usermodel.name = snapshot.data!.docs[i][kName];
              usermodel.email = snapshot.data!.docs[i][kEmail];
              usermodel.bio = snapshot.data!.docs[i][kBio];
            }
          }

          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          kPrimaryColor,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          child: usermodel.stringImage == null
                              ? const CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA9j-C3_YS7NAVZT4572tFatGX80YHRePaPNUnbLmlRWrSPgeqbeaj1mMd0F5IgW_G8_A&usqp=CAU'),
                                )
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundImage:
                                      NetworkImage(usermodel.stringImage!),
                                ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfileView(usermodel: usermodel);
                            }));
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, WelcomeView.id);
                          },
                          icon: const Icon(
                            Icons.exit_to_app_rounded,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  height: 24,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: myUsers.length,
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: UserTile(
                          myFreind: myUsers[index],
                          usermodel: usermodel,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          {
            return const Scaffold(
                backgroundColor: kPrimaryColor,
                body: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )));
          }
        }
      },
    );
  }
}
