import 'dart:convert';
import 'package:gharsa_app/features/chatbot/data/models/chat_message_response_model.dart';
import 'package:gharsa_app/features/chatbot/data/models/chat_session_model.dart';
import 'package:http/http.dart' as http;
import 'package:gharsa_app/features/auth/api/api_service.dart';

class ChatBotApiService {
  final ApiService apiService;

  ChatBotApiService(this.apiService);

  /// ================= CREATE SESSION =================
  Future<ChatSessionModel> createChatSession() async {
    final url = Uri.parse('https://gharsa.semiona.com/api/chat/sessions');

    final response = await http.post(
      url,
      headers: await apiService.getHeaders(),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ChatSessionModel.fromJson(data);
    } else {
      throw Exception(data['message']);
    }
  }

  /// ================= SEND MESSAGE =================
  Future<ChatMessageResponseModel> sendMessage({
    required int sessionId,
    required String message,
  }) async {
    final url = Uri.parse(
      'https://gharsa.semiona.com/api/chat/sessions/$sessionId/messages',
    );

    final response = await http.post(
      url,
      headers: await apiService.getHeaders(),
      body: jsonEncode({"content": message}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ChatMessageResponseModel.fromJson(data);
    } else {
      throw Exception(data['message']);
    }
  }
}
