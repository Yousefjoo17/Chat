import 'package:chat/Cubits/EditProfile_cubit/edit_profile_cubit.dart';
import 'package:chat/Cubits/Usertile_cubit/user_tile_cubit.dart';
import 'package:chat/Cubits/auth_cubit/auth_cubit.dart';
import 'package:chat/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat/Simple_Bloc_observer.dart';
import 'package:chat/Views/Welcome_view.dart';
import 'package:chat/Views/otp_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => UserTileCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          WelcomeView.id: (context) => const WelcomeView(),
          //PhonePage.id: (context) => const PhonePage(),
          OTPView.id: (context) => const OTPView(),
          // RegisterView.id: (context) => const RegisterView(),
        },
        initialRoute: WelcomeView.id,
      ),
    );
  }
}
