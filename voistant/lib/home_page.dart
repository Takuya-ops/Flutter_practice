import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voistant/feature_box.dart';
import 'package:voistant/openai_service.dart';
import 'package:voistant/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 音声入力の設定
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = "";
  // 作成したopenai_serviceのクラスをインスタンス化
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
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

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbarの文字表示
      appBar: AppBar(
        // 文字が上から落ちてくるような表示にできる
        title: BounceInDown(
          child: Text(
            "ChatGPT",
          ),
        ),
        // ハンバーガーマーク
        leading: Icon(Icons.menu),
      ),
      // 写真の設定
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 徐々に大きくなっていくような表示にできる
            ZoomIn(
              child: Stack(
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
            ),
            // テキストボックスの作成
            // 右から文字が出てくるような表示にできる
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent == null
                          ? "Hi! May I help you?"
                          : generatedContent!,
                      style: TextStyle(
                        fontFamily: "Cera Pro",
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null ? 20 : 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(generatedImageUrl!)),
              ),
            // ２行目のテキストの表示
            // 左から文字が出てくるような設定
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
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
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  // feature_boxで定義したクラスを使用
                  // chatGPTの項目
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: FeatureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      headerText: "ChatGPT",
                      descriptionText:
                          "You can use gpt3.5-turbo released by OpenAI",
                    ),
                  ),
                  // Dalle-Eの項目
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay),
                    child: FeatureBox(
                      color: Pallete.assistantCircleColor,
                      headerText: "Dall-E",
                      descriptionText:
                          "You can use generative image model（Dall-E） released by OpenAI",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: FeatureBox(
                      color: Pallete.yellowColor,
                      headerText: "Voice assistant",
                      descriptionText:
                          "Voice input is available \n（ChatGPT or Dall-E）",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // マイクのアイコンを表示させる（Scaffoldウィジェット内に記載する）
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          // マイクボタンを押した時、音声認識をスタートさせる
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              // マイクを止めた時にhttpリクエストを投げるようにする
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains("https")) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          // マイクのアイコン表示を変える
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic,
          ),
        ),
      ),
    );
  }
}
