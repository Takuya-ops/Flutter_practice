import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zoom_clone/widgets/custom_button.dart';
import 'package:zoom_clone/widgets/signup_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "さあ、始めましょう！",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          CustomButton(
            text: "ログイン",
          ),
          SizedBox(
            height: 10,
          ),
          SignupButton(
            text: "サインアップ",
          )
        ],
        // mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
