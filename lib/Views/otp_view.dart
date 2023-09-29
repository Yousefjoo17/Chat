import 'package:chat/Views/Home_view.dart';
import 'package:chat/constants.dart';
import 'package:chat/Cubits/auth_cubit/auth_cubit.dart';
import 'package:chat/Views/Register_view.dart';
import 'package:chat/Views/methods/Custom_Box_Decoration.dart';
import 'package:chat/helper/Show_snack_bar.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/Views/widgets/Custom_Button.dart';
import 'package:chat/Views/widgets/OTP_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});
  static String id = 'Otp page';
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Usermodel usermodel =
        ModalRoute.of(context)!.settings.arguments as Usermodel;
    usermodel.otpCode = '012345';
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyOTPLoading) {
          isLoading = true;
        } else if (state is VerifyOTPSuccess) {
          isLoading = false;
          if (usermodel.newUser!) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterView(usermodel: usermodel)));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(usermodel: usermodel)));
          }
        } else if (state is VerifyOTPFailure) {
          isLoading = false;
          showmySnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  decoration: customBoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset(
                        'assets/images/illustration2.png',
                        fit: BoxFit.fill,
                        height: 280,
                        width: 280,
                      ),
                      const Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Enter your otp code number',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            children: [
                              OTPtextform(usermodel: usermodel),
                              const SizedBox(height: 16),
                              CustomButton(
                                text: 'verify',
                                ontap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .sentcode(usermodel: usermodel);
                                },
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
