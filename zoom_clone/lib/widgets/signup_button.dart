import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignupButton extends StatelessWidget {
  final String text;
  const SignupButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 100,
        right: 100,
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          text,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            double.infinity,
            40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
