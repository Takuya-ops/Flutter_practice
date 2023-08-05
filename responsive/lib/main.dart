import 'package:flutter/material.dart';
import 'package:responsive/layout_builder_example.dart';
import 'package:responsive/media_query_example.dart'; // 新しく作成したファイルをインポート

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MediaQuery Example'),
        ),
        body: Center(
          // child: MediaQueryExample(),
          child: LayoutBuilderExample(), // 新しく作成したウィジェットを読み込む
        ),
      ),
    );
  }
}
