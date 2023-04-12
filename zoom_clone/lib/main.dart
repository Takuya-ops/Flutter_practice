import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   '/login': (context) => const LoginScreen(),
      // }
      home: LoginScreen(),
    );
  }
}
