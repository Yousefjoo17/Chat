import 'package:chat/constants.dart';
import 'package:chat/Cubits/auth_cubit/auth_cubit.dart';
import 'package:chat/helper/Show_snack_bar.dart';
import 'package:chat/Views/methods/Custom_Box_Decoration.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/Views/otp_view.dart';
import 'package:chat/Views/widgets/Custom_Button.dart';
import 'package:chat/Views/widgets/Custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({
    super.key,
    required this.usermodel,
  });
  static String id = 'phone page';
  final Usermodel usermodel;

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PhoneNumSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, OTPView.id, arguments: widget.usermodel);
        } else if (state is PhoneNumLoading) {
          isLoading = true;
        } else if (state is PhoneNumFailure) {
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
              child: Form(
                key: formkey,
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
                          'assets/images/illustration1.png',
                          fit: BoxFit.fill,
                          height: 300,
                          width: 150,
                        ),
                        const Text(
                          'Join Chatty world',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'Add your phone number. we will send you a code so we know you are real ',
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
                                CustomTextField(
                                  hinttext: '+00 0000 0000 00',
                                  onchanged: (value) {
                                    widget.usermodel.phoneNumber =
                                        value.replaceAll(' ', '');
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomButton(
                                  text: 'Send',
                                  color: kPrimaryColor,
                                  ontap: () async {
                                    if (formkey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .checkUser(widget.usermodel);

                                      await BlocProvider.of<AuthCubit>(context)
                                          .verifyPhoneNumber(widget.usermodel);
                                    }
                                  },
                                )
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
          ),
        );
      },
    );
  }
}
