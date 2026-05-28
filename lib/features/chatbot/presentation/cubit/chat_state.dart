import 'package:gharsa_app/features/chatbot/data/models/chat_message_model.dart';

class ChatState {
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final bool isBotTyping;

  const ChatState({
    required this.messages,
    required this.isLoading,
    required this.isBotTyping,
  });

  factory ChatState.initial() {
    return const ChatState(messages: [], isLoading: false, isBotTyping: false);
  }

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    bool? isBotTyping,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isBotTyping: isBotTyping ?? this.isBotTyping,
    );
  }
}
