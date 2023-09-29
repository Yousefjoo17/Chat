import 'package:chat/constants.dart';
import 'package:chat/Views/methods/Custom_Box_Decoration.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/Views/Phone_view.dart';
import 'package:chat/Views/widgets/Custom_Button.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  static String id = 'Phone Page';
  @override
  Widget build(BuildContext context) {
    Usermodel usermodel = Usermodel();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Container(
          decoration: customBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 92),
              Image.asset(
                'assets/images/chat_logo.png',
                fit: BoxFit.fill,
                height: 150,
                width: 175,
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'get started with ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Chatty',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Never a better time than now to start',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 82),
              CustomButton(
                text: 'Join !',
                color: kPrimaryColor,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneView(
                              usermodel: usermodel,
                            )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
