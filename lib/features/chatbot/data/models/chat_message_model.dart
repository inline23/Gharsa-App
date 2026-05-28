class ChatMessageModel {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.time,
  });
}