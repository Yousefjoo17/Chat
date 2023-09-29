import 'package:chat/Cubits/auth_cubit/auth_cubit.dart';
import 'package:chat/Views/Home_view.dart';
import 'package:chat/constants.dart';
import 'package:chat/Views/methods/Custom_Box_Decoration.dart';
import 'package:chat/Views/widgets/CustomTextfield_Register.dart';
import 'package:chat/Views/widgets/Custom_Button.dart';
import 'package:chat/helper/Show_snack_bar.dart';
import 'package:chat/models/User_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.usermodel});
  static String id = 'Register view';
  final Usermodel usermodel;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage(usermodel: widget.usermodel);
          }));
        } else if (state is RegisterFailure) {
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
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.1,
                      decoration: customBoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            children: [
                              widget.usermodel.uint8Listimage == null
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 64,
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA9j-C3_YS7NAVZT4572tFatGX80YHRePaPNUnbLmlRWrSPgeqbeaj1mMd0F5IgW_G8_A&usqp=CAU'),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(
                                          widget.usermodel.uint8Listimage!),
                                    ),
                              Positioned(
                                bottom: -12,
                                right: -5,
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .pickImage(widget.usermodel);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    size: 31,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          CustomTextFieldRegister(
                            icon: const Icon(Icons.person,
                                color: kPrimaryColor, size: 30),
                            hinText: 'Name',
                            onChanged: (value) {
                              widget.usermodel.name = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFieldRegister(
                            icon: const Icon(Icons.email,
                                color: kPrimaryColor, size: 30),
                            hinText: 'Email',
                            onChanged: (value) {
                              widget.usermodel.email = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFieldRegister(
                            icon: const Icon(Icons.store_mall_directory,
                                color: kPrimaryColor, size: 30),
                            hinText: 'Enter here your bio',
                            maxLines: 3,
                            onChanged: (value) {
                              widget.usermodel.bio = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Complete',
                            color: kPrimaryColor,
                            ontap: () {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .saveUser(widget.usermodel);
                              }
                            },
                          ),
                        ],
                      ),
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
