import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:voistant/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatGPT"),
        leading: Icon(Icons.menu),
      ),
      body: Column(children: [
        Stack(
          // アシスタント画像の配置
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle),
              ),
            ),
            Container(
              height: 120,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/virtualAssistant.png",
                  ),
                ),
              ),
            )
          ],
        ),
        // テキストボックスの作成
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
            top: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Pallete.blackColor,
            ),
            // 左上の角だけ丸くしない
            borderRadius: BorderRadius.circular(20).copyWith(
              topLeft: Radius.zero,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Hi! May I help you?",
              style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor,
                  fontSize: 20),
            ),
          ),
        )
      ]),
    );
  }
}
