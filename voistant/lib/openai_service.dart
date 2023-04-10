import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voistant/secrets.dart';

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      // awaitをつけないとprint(res.body)のとこでエラーが出る
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIAPIKey",
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": "Please generate question below text. \n $prompt",
              },
            ],
          },
        ),
      );
      print(res.body);
      if (res.statusCode == 200) {
        print("ya!");
      }
      return "AI";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    return "chatGPT";
  }

  Future<String> dallEAPI(String prompt) async {
    return "Dall-E";
  }
}
