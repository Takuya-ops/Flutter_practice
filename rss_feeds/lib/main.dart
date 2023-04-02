import 'package:flutter/material.dart';
import 'package:rss_feeds/rss.dart';
import 'package:rss_feeds/rss_';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 最初に起動する画面
      home: RSS(),
    );
  }
}
