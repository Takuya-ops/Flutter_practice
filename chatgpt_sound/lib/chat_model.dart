enum ChatMessageType { user, bot }

class ChatMessage {
  ChatMessage({required this.text, required this.type});
  // ?はnull許容演算子 → nullである可能性がある
  String? text;
  ChatMessageType? type;
}
