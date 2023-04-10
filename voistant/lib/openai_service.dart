import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voistant/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
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
        //  返ってきた文章を取り出す
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        // 空白を除去する
        content = content.trim();

        switch (content) {
          case "Yes":
          case "yes":
          case "Yes.":
          case "yes.":
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
        }
      }
      return "An internal error occured";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });
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
            "messages": messages,
          },
        ),
      );

      if (res.statusCode == 200) {
        //  返ってきた文章を取り出す
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        // 空白を除去する
        content = content.trim();

        messages.add(
          {
            "role": "assistant",
            "content": content,
          },
        );
        return content;
      }
      return "An internal error occured";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      // awaitをつけないとprint(res.body)のとこでエラーが出る
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIAPIKey",
        },
        body: jsonEncode(
          {
            "prompt": prompt,
            "n": 2,
          },
        ),
      );

      if (res.statusCode == 200) {
        //  返ってきた文章を取り出す
        String imageUrl = jsonDecode(res.body)["data"][0]["url"];
        // 空白を除去する
        imageUrl = imageUrl.trim();

        messages.add(
          {
            "role": "assistant",
            "content": imageUrl,
          },
        );
        return imageUrl;
      }
      return "An internal error occured";
    } catch (e) {
      return e.toString();
    }
  }
}
