import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:dart_openai/openai.dart";

// APIキーを入力してください。
String apiKey = "";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey"
  };

  static sendMessage(String? message) async {
    var res = await http.post(
      Uri.parse(baseUrl),
      headers: header,
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          // "model": "gpt-3.5-turbo",
          "prompt": "$message" + "突っ込んだ質問を何個か表示してください。",
          "max_tokens": 1000,
          "temperature": 0,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": ["Human:", "AI:"]
        },
      ),
    );

    // var res = await http.post(
    //   Uri.parse(baseUrl),
    //   headers: header,
    //   body: jsonEncode(
    //     {
    //       "model": "gpt-3.5-turbo",
    //       "prompt": message,
    //       "max_tokens": 300,
    //     },
    //   ),
    // );

    // OpenAIChatCompletionModel chatCompletion =
    //     await OpenAI.instance.chat.create(
    //   model: "gpt-3.5-turbo",
    //   messages: [
    //     OpenAIChatCompletionChoiceMessageModel(
    //       content: "hello, what is Flutter and Dart ?",
    //       role: "user",
    //     ),
    //   ],
    // );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());

      // あとで見直す
      var msg = data['choices'][0]["text"];
      // var msg = ["choices"][index]["text"];
      // var msg = data.choices.first.message;
      // 文字化け対策
      return utf8.decode(msg.runes.toList());
    } else {
      print("Feiled to fetch data");
    }
  }
}
