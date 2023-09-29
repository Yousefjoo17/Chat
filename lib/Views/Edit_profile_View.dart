import 'package:chat/Cubits/EditProfile_cubit/edit_profile_cubit.dart';
import 'package:chat/Views/Home_view.dart';
import 'package:chat/Views/methods/Custom_Box_Decoration.dart';
import 'package:chat/Views/widgets/CustomTextfield_Register.dart';
import 'package:chat/Views/widgets/Custom_Button.dart';
import 'package:chat/constants.dart';
import 'package:chat/helper/Show_snack_bar.dart';
import 'package:chat/models/User_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.usermodel});
  final Usermodel usermodel;
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool isLoading = false;
  Usermodel alteruser = Usermodel();
  String? name, email, bio;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoading) {
          isLoading = true;
        } else if (state is EditProfileSuccess) {
          isLoading = false;

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage(usermodel: widget.usermodel);
          }));
        } else if (state is EditProfileFailure) {
          isLoading = false;
          showmySnackBar(context, state.errMessage);
        } else {
          isLoading = false;
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
                            alteruser.uint8Listimage == null
                                ? widget.usermodel.stringImage == null
                                    ? const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 64,
                                        backgroundImage: NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA9j-C3_YS7NAVZT4572tFatGX80YHRePaPNUnbLmlRWrSPgeqbeaj1mMd0F5IgW_G8_A&usqp=CAU'),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 64,
                                        backgroundImage: NetworkImage(
                                            widget.usermodel.stringImage!),
                                      )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage:
                                        MemoryImage(alteruser.uint8Listimage!),
                                  ),
                            Positioned(
                              bottom: -12,
                              right: -5,
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<EditProfileCubit>(context)
                                      .pickImage(alteruser);
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
                          hinText: widget.usermodel.name!,
                          hintTextColor: Colors.black,
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldRegister(
                          icon: const Icon(Icons.email,
                              color: kPrimaryColor, size: 30),
                          hinText: widget.usermodel.email!,
                          hintTextColor: Colors.black,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldRegister(
                          icon: const Icon(Icons.store_mall_directory,
                              color: kPrimaryColor, size: 30),
                          hinText: widget.usermodel.bio!,
                          hintTextColor: Colors.black,
                          maxLines: 3,
                          onChanged: (value) {
                            bio = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Save',
                          color: kPrimaryColor,
                          ontap: () {
                            widget.usermodel.name =
                                name ?? widget.usermodel.name;
                            widget.usermodel.email =
                                email ?? widget.usermodel.email;
                            widget.usermodel.bio = bio ?? widget.usermodel.bio;
                            widget.usermodel.uint8Listimage =
                                alteruser.uint8Listimage ??
                                    widget.usermodel.uint8Listimage;
                            BlocProvider.of<EditProfileCubit>(context)
                                .editUserData(widget.usermodel);
                          },
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
