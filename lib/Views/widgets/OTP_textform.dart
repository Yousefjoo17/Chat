import 'package:chat/models/User_model.dart';
import 'package:chat/Views/widgets/OTP_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OTPtextform extends StatelessWidget {
  OTPtextform({super.key, required this.usermodel});
  Usermodel usermodel;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OTPitem(index: 0, first: true, usermodel: usermodel),
        OTPitem(index: 1, usermodel: usermodel),
        OTPitem(index: 2, usermodel: usermodel),
        OTPitem(index: 3, usermodel: usermodel),
        OTPitem(index: 4, usermodel: usermodel),
        OTPitem(index: 5, last: true, usermodel: usermodel),
      ],
    ));
  }
}
