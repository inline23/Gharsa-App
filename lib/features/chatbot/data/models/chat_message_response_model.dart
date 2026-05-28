class ChatMessageResponseModel {
  final bool? success;
  final String? message;
  final ChatMessageData? data;

  ChatMessageResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ChatMessageResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChatMessageResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ChatMessageData.fromJson(json['data'])
          : null,
    );
  }
}

class ChatMessageData {
  final int? sessionId;
  final bool? fallback;
  final ChatBotMessage? message;

  ChatMessageData({
    this.sessionId,
    this.fallback,
    this.message,
  });

  factory ChatMessageData.fromJson(Map<String, dynamic> json) {
    return ChatMessageData(
      sessionId: json['session_id'],
      fallback: json['fallback'],
      message: json['message'] != null
          ? ChatBotMessage.fromJson(json['message'])
          : null,
    );
  }
}

class ChatBotMessage {
  final int? id;
  final String? role;
  final String? content;
  final String? provider;
  final String? model;
  final int? latencyMs;
  final MessageMeta? meta;
  final int? chatSessionId;
  final String? createdAt;
  final String? updatedAt;

  ChatBotMessage({
    this.id,
    this.role,
    this.content,
    this.provider,
    this.model,
    this.latencyMs,
    this.meta,
    this.chatSessionId,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatBotMessage.fromJson(Map<String, dynamic> json) {
    return ChatBotMessage(
      id: json['id'],
      role: json['role'],
      content: json['content'],
      provider: json['provider'],
      model: json['model'],
      latencyMs: json['latency_ms'],
      meta: json['meta'] != null
          ? MessageMeta.fromJson(json['meta'])
          : null,
      chatSessionId: json['chat_session_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class MessageMeta {
  final String? requestId;
  final String? replyLocale;

  MessageMeta({
    this.requestId,
    this.replyLocale,
  });

  factory MessageMeta.fromJson(Map<String, dynamic> json) {
    return MessageMeta(
      requestId: json['request_id'],
      replyLocale: json['reply_locale'],
    );
  }
}