import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/chatbot/api/chat_bot_api_service.dart';
import 'package:gharsa_app/features/chatbot/data/models/chat_message_model.dart';
import 'package:gharsa_app/features/chatbot/data/models/chat_session_model.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatBotApiService api;

  int? sessionId;

  ChatCubit(this.api) : super(ChatState.initial());

  /// ================= CREATE SESSION =================
  Future<void> createSession() async {
    try {
      emit(state.copyWith(isLoading: true));

      final ChatSessionModel res = await api.createChatSession();

      sessionId = res.data?.id;

      print("SESSION CREATED: $sessionId");

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      print("CREATE SESSION ERROR: $e");

      emit(state.copyWith(isLoading: false));
    }
  }

  /// ================= SEND MESSAGE =================
  Future<void> sendMessage(String text) async {
    try {
      /// CREATE SESSION IF NULL
      if (sessionId == null) {
        print("SESSION NULL → creating new session");

        await createSession();
      }

      /// USER MESSAGE
      final userMsg = ChatMessageModel(
        text: text,
        isUser: true,
        time: DateTime.now(),
      );

      final messages = List<ChatMessageModel>.from(state.messages)
        ..add(userMsg);

      /// SHOW USER MSG + TYPING
      emit(
        state.copyWith(messages: messages, isLoading: true, isBotTyping: true),
      );

      /// API REQUEST
      final res = await api.sendMessage(sessionId: sessionId!, message: text);

      print("RAW BOT RESPONSE: $res");

      /// BOT CONTENT
      final botContent =
          res.data?.message?.content ??
          res.data?.message ??
          "No response from server";

      /// BOT MESSAGE
      final botMsg = ChatMessageModel(
        text: botContent.toString(),
        isUser: false,
        time: DateTime.now(),
      );

      final updatedMessages = List<ChatMessageModel>.from(messages)
        ..add(botMsg);

      /// FINAL EMIT
      emit(
        state.copyWith(
          messages: updatedMessages,
          isLoading: false,
          isBotTyping: false,
        ),
      );
    } catch (e) {
      print("SEND MESSAGE ERROR: $e");

      emit(state.copyWith(isLoading: false, isBotTyping: false));
    }
  }
}
