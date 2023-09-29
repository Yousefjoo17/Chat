import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.ontap,
      required this.color,
      this.textColor});
  final String? text;
  final VoidCallback? ontap;
  final Color color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 211, 211, 211),
              blurRadius: 25,
            )
          ],
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(fontSize: 25, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
