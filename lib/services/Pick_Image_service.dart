import 'package:chat/models/User_model.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  pickImage(Usermodel usermodel) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      usermodel.uint8Listimage = await file.readAsBytes();
    } else {
      print('No image selectef');
    }
  }
}
