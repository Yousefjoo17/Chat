import 'package:chat/constants.dart';
import 'package:chat/models/User_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OTPitem extends StatelessWidget {
  OTPitem(
      {super.key,
      required this.index,
      this.first = false,
      this.last = false,
      required this.usermodel});
  final bool first, last;
  final int index;
  Usermodel usermodel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            usermodel.otpCode = usermodel.otpCode!.substring(0, index) +
                value +
                usermodel.otpCode!.substring(index + 1);
          }

          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        onSaved: (value) {},
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
