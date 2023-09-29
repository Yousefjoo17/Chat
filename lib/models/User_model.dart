import 'dart:typed_data';

class Usermodel {
  String? name;
  String? phoneNumber;
  String? bio;
  String? otpCode;
  String? email;
  Uint8List? uint8Listimage;
  String? stringImage;
  String? docID;
  bool? newUser;
  Usermodel({
    this.docID,
    this.name,
    this.bio,
    this.phoneNumber,
    this.email,
    this.uint8Listimage,
    this.stringImage,
    this.newUser,
  });
}
