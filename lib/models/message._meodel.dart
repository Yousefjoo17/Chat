import 'package:chat/constants.dart';

class Message {
  final String message;
  final String id;
  final String docID;
  bool seen;
  Message(this.message, this.id, this.docID, this.seen);
  factory Message.fromjson(jsondata) {
    return Message(
      jsondata[kMessage],
      jsondata[kPhoneNumber],
      jsondata[kDocID],
      jsondata[kSeen],
    );
  }
}
