 import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration() {
    return BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xffF7F6FB),
              kPrimaryColor,
            ],
            stops: [0.4, 0.85, 1],
          ),
        );
  }