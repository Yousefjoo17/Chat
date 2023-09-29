import 'package:bloc/bloc.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/services/Pick_Image_service.dart';
import 'package:chat/services/Store_Userdata_service.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  pickImage(Usermodel usermodel) async {
    try {
      await PickImageService().pickImage(usermodel);
      emit(EditProfileImageSuccess());
    } catch (e) {
      print(e);
    }
  }

  editUserData(Usermodel usermodel) async {
    emit(EditProfileLoading());
    StoreDataService storeData = StoreDataService();
    try {
      await storeData.saveData(usermodel: usermodel);
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileFailure('something went wrong'));
    }
  }
}
