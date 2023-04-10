import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voistant/feature_box.dart';
import 'package:voistant/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 音声入力の設定
  final speechToText = SpeechToText();
  String lastWords = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbarの文字表示
      appBar: AppBar(
        title: Text(
          "ChatGPT",
        ),
        // ハンバーガーマーク
        leading: Icon(Icons.menu),
      ),
      // 写真の設定
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // アシスタント画像を配置する枠の設定
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 10),
                    // 画像の背景色
                    // decoration: BoxDecoration(
                    //   color: Pallete.assistantCircleColor,
                    //   shape: BoxShape.circle,
                    // ),
                  ),
                ),
                // アシスタント画像の設定
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
              // 枠の大きさの設定
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              // 上の画像との間隔の設定
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 20,
              ),
              decoration: BoxDecoration(
                // 枠線の設定
                border: Border.all(
                  color: Pallete.blackColor,
                ),
                // 角の丸み具合の設定
                borderRadius: BorderRadius.circular(20).copyWith(
                  // 左上の角だけ丸くしない
                  topLeft: Radius.zero,
                ),
              ),
              // 中に入れる文字の設定
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Hi! May I help you?",
                  style: TextStyle(
                    fontFamily: "Cera Pro",
                    color: Pallete.mainFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // ２行目のテキストの表示
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                "Please choice below!",
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                // feature_boxで定義したクラスを使用
                // chatGPTの項目
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: "ChatGPT",
                  descriptionText:
                      "You can use gpt3.5-turbo released by OpenAI",
                ),
                // Dalle-Eの項目
                FeatureBox(
                  color: Pallete.assistantCircleColor,
                  headerText: "Dall-E",
                  descriptionText:
                      "You can use generative image model（Dall-E） released by OpenAI",
                ),
                FeatureBox(
                  color: Pallete.yellowColor,
                  headerText: "Voice assistant",
                  descriptionText:
                      "Voice input is available \n（ChatGPT or Dall-E）",
                ),
              ],
            ),
          ],
        ),
      ),
      // マイクのアイコンを表示させる（Scaffoldウィジェット内に記載する）
      floatingActionButton: FloatingActionButton(
        // マイクボタンを押した時、音声認識をスタートさせる
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
