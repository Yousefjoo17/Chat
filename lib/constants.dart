import 'package:flutter/material.dart';

const Color kPrimaryColor = Color.fromARGB(255, 123, 73, 214);
const String klogo = 'assets/images/chat_logo.png';
const String kDocID = 'docID';
const String kcreatedAt = 'createdAt';

//////////////////////////////////////

const String kMessagesCollection = 'Messages';
const String kMessage = 'message';
const String kSeen = 'seen';

/////////////////////////////////////////

const String kUsersCollection = 'Users';
const String kName = 'Name';
const String kPhoneNumber = 'Phone number';
const String kImage = 'profile Image';
const String kBio = 'bio';
const String kEmail = 'email';
const String kProfileImage = 'profileImage';




//the spacer widget cannot be used in somwhere we don't know
// its space for ex we can't use it inside listview
// 0xff6C62FF


/*

 Image.asset(
                    usermodel.image?? 'assets/images/userPhoto.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('upload'),
                        Image.asset(
                          'assets/images/uploadPhoto.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.fill,
                        ),
                        const Text('photo'),
                      ],
                    ),
                    onTap: () {},
                  ),
 */