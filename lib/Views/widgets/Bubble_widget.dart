import 'package:chat/models/message._meodel.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final Message message;
  final Icon icon;
  const BubbleChat({required this.message, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      //(نفس الكلام بس هنا هي بتكبر مساحة المحيط للكونتيانر نفسه (الجزء الفاضي الابيض
      child: Container(
        //  alignment: Alignment.centerLeft, بتكبر مساحة الكونتاينر اوي علشان تديك سبيس انك تحرك التيكست زي مانت عايز
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 30),
        //بتظبط الطفل

        margin: const EdgeInsets.all(10), //بيظبط الاب

        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 198, 177, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleChatFriend extends StatelessWidget {
  final Message message;
  final Icon icon;

  const BubbleChatFriend(
      {super.key, required this.message, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      //(نفس الكلام بس هنا هي بتكبر مساحة المحيط للكونتيانر نفسه (الجزء الفاضي الابيض
      child: Container(
        //  alignment: Alignment.centerLeft, بتكبر مساحة الكونتاينر اوي علشان تديك سبيس انك تحرك التيكست زي مانت عايز
        padding: const EdgeInsets.only(
            top: 20, bottom: 20, left: 20, right: 30), //بتظبط الطفل

        margin: const EdgeInsets.all(10), //بيظبط الاب

        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 164, 221, 248),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
