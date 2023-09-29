import 'dart:typed_data';
import 'package:chat/constants.dart';
import 'package:chat/models/User_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreDataService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, Usermodel usermodel) async {
    Reference ref =
        storage.ref().child(childName).child(usermodel.phoneNumber!);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({required Usermodel usermodel}) async {
    String resp = " Some Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage(
          kProfileImage, usermodel.uint8Listimage!, usermodel);

      String docId = users.doc().id;
      await users.doc(docId).set({
        kDocID: docId,
        kName: usermodel.name,
        kEmail: usermodel.email,
        kBio: usermodel.bio,
        kImage: imageUrl,
        kPhoneNumber: usermodel.phoneNumber,
        kcreatedAt: DateTime.now(),
      });
      usermodel.docID = docId;
      usermodel.stringImage = imageUrl;

      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
