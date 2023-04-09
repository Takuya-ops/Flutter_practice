import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:voistant/pallete.dart';

class FeatureBox extends StatelessWidget {
  // 具体的な値はhome_page.dartのファイル内で記述する
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        // padding: EdgeInsets.symmetric(vertical: 20).copyWith(
        //   left: 15,
        // ),
        child: Column(
          children: [
            // 題目
            // WidgetをAlignに変更
            Align(
              // 左寄せにする
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 題目と説明文の間隔を空ける
            SizedBox(
              height: 2,
            ),
            // 説明文
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                descriptionText,
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
