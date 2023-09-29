import 'package:bloc/bloc.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/services/Pick_Image_service.dart';
import 'package:chat/services/Store_Userdata_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(PhoneNumInitial());

  FirebaseAuth auth = FirebaseAuth.instance;
  String? verifiedID;
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);

  checkUser(Usermodel usermodel) async {
    emit(PhoneNumLoading());

    try {
      QuerySnapshot querySnapshot = await users.get();
      usermodel.newUser = true;
      for (var user in querySnapshot.docs) {
        if (user[kPhoneNumber] == usermodel.phoneNumber) {
          usermodel.newUser = false;
          break;
        }
      }
    } catch (e) {
      emit(PhoneNumFailure('something went wrong'));
    }
  }

  Future<void> verifyPhoneNumber(Usermodel usermodel) async {
    emit(PhoneNumLoading());

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: usermodel.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          verifiedID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      emit(PhoneNumSuccess());
    } catch (e) {
      emit(PhoneNumFailure('something went wrong'));
    }
  }

  sentcode({required Usermodel usermodel}) async {
    emit(VerifyOTPLoading());
    try {
      String smsCode = usermodel.otpCode!;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifiedID!, smsCode: smsCode);
      await auth.signInWithCredential(credential);

      emit(VerifyOTPSuccess());
    } catch (e) {
      emit(VerifyOTPFailure(e.toString()));
    }
  }

  pickImage(Usermodel usermodel) async {
    try {
      await PickImageService().pickImage(usermodel);
      emit(UploadImageSuccess());
    } catch (e) {
      print(e);
    }
  }

  saveUser(Usermodel usermodel) async {
    emit(RegisterLoading());
    StoreDataService storeData = StoreDataService();
    try {
      await storeData.saveData(usermodel: usermodel);
    } catch (e) {
      emit(RegisterFailure('something went wrong'));
    }
    emit(RegisterSuccess());
  }
}
