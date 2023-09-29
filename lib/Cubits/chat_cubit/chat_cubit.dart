import 'package:chat/constants.dart';
import 'package:chat/models/User_model.dart';
import 'package:chat/models/message._meodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messageslist = [];

  CollectionReference identifyCollection(
      {required Usermodel usermodel, required String myFriendphonenumber}) {
    String collection;

    if (usermodel.phoneNumber!.compareTo(myFriendphonenumber) > 0) {
      collection = usermodel.phoneNumber! + myFriendphonenumber;
    } else {
      collection = myFriendphonenumber + usermodel.phoneNumber!;
    }
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection(collection);
    return messagesCollection;
  }

  Future<void> sendMessage({
    required CollectionReference collectionReference,
    required String message,
    required Usermodel usermodel,
  }) async {
    String docId = collectionReference.doc().id;
    try {
      await collectionReference.doc(docId).set({
        kMessage: message,
        kcreatedAt: DateTime.now(),
        kPhoneNumber: usermodel.phoneNumber,
        kSeen: false,
        kDocID: docId,
      });
    } catch (e) {
      emit(ChatFailure());
      print(e);
    }
  }

  Future<void> getMessages({
    required CollectionReference collectionReference,
    required Usermodel usermodel,
  }) async {
    collectionReference
        .orderBy(kcreatedAt, descending: true)
        .snapshots()
        .listen(
      (event) async {
        //Listen.. each time update happens(event changes) do what I ask you here{}
        //هو هنا حاطط ودنه مع الدوكس اللي عندي في الداتا بيز اي حاجة توصل بيلقطها علي طول ويعمل اللي جوة الاقواص علشان هو رجا جدع
        messageslist.clear();
        for (var message in event.docs) {
          messageslist.add(Message.fromjson(message));
        }
        try {
          for (var message in messageslist) {
            print(message.docID);
            if (usermodel.phoneNumber != message.id) {
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              await firestore
                  .collection(collectionReference.path)
                  .doc(message.docID)
                  .update({kSeen: true});
              message.seen = true;
            }
            emit(ChatSuccess(messageslist: messageslist));
          }
        } catch (e) {
          emit(ChatFailure());
        }
      },
    );
  }
}
