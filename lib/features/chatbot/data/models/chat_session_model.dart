class ChatSessionModel {
  final bool? success;
  final String? message;
  final ChatSessionData? data;

  ChatSessionModel({
    this.success,
    this.message,
    this.data,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ChatSessionData.fromJson(json['data'])
          : null,
    );
  }
}

class ChatSessionData {
  final int? id;
  final int? userId;
  final int? soilAnalysisId;
  final String? title;
  final String? locale;
  final String? status;
  final String? lastMessageAt;
  final String? createdAt;
  final String? updatedAt;

  ChatSessionData({
    this.id,
    this.userId,
    this.soilAnalysisId,
    this.title,
    this.locale,
    this.status,
    this.lastMessageAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatSessionData.fromJson(Map<String, dynamic> json) {
    return ChatSessionData(
      id: json['id'],
      userId: json['user_id'],
      soilAnalysisId: json['soil_analysis_id'],
      title: json['title'],
      locale: json['locale'],
      status: json['status'],
      lastMessageAt: json['last_message_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}