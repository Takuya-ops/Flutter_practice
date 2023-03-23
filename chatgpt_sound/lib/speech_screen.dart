import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgpt_sound/api_services.dart';
import 'package:chatgpt_sound/chat_model.dart';
import 'package:chatgpt_sound/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  // 音声→テキストへの変換
  SpeechToText speechToText = SpeechToText();
  var text = "Hold the button and start speaking";
  // マイクボタンを押した時のみ録音するようにする
  var isListening = false;
  final List<ChatMessage> messages = [];

  var scrollController = ScrollController();

  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        // マイクボタンを押した時のみ起動するようにする
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: bgColor,
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          // マイクボタンを押した時（録音を始めたい時）
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(
                        () {
                          text = result.recognizedWords;
                        },
                      );
                    },
                  );
                });
              }
            }
            setState(() {
              isListening = true;
            });
          },
          // 録音を止める時
          onTapUp: (details) async {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
            messages.add(ChatMessage(text: text, type: ChatMessageType.user));
            var msg = await ApiServices.sendMessage(text);

            setState(() {
              messages.add(ChatMessage(text: msg, type: ChatMessageType.bot));
            });
          },
          child: CircleAvatar(
            backgroundColor: bgColor,
            radius: 35,
            // マイクONとOFFの時でアイコンの表示を変える
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        backgroundColor: bgColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "ChatGPT",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // リアルタイム文字起こしの表示
            // Text(
            //   text,
            //   style: TextStyle(
            //       fontSize: 16,
            //       color: isListening ? Colors.black87 : Colors.black54,
            //       fontWeight: FontWeight.w600),
            // ),
            // 間隔を取りたい時に使用
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: chatBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = messages[index];

                    return chatBubble(
                      chattext: chat.text,
                      type: chat.type,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Developed by Takuya",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget chatBubble({required chattext, required ChatMessageType? type}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: bgColor,
        child: type == ChatMessageType.bot
            ? Image.asset(
                "assets/images/icon.png",
                fit: BoxFit.cover,
              )
            : Icon(Icons.person, color: Colors.white),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            "$chattext",
            style: TextStyle(
              color: chatBgColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
  );
}
