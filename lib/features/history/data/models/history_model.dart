import 'package:gharsa_app/features/soil%20anaylsis/data/models/crop_recommendation.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/recommendations.dart';

class HistoryModel {
  final bool? success;
  final String? message;
  final List<HistoryItem>? data;

  HistoryModel({this.success, this.message, this.data});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => HistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class HistoryItem {
  final int? id;
  final RequestPayload? requestPayload;
  final ResponsePayload? responsePayload;
  final bool? isSuccess;
  final String? errorMessage;
  final int? mlStatusCode;
  final String? createdAt;

  HistoryItem({
    this.id,
    this.requestPayload,
    this.responsePayload,
    this.isSuccess,
    this.errorMessage,
    this.mlStatusCode,
    this.createdAt,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      requestPayload: json['request_payload'] != null
          ? RequestPayload.fromJson(json['request_payload'])
          : null,
      responsePayload: json['response_payload'] != null
          ? ResponsePayload.fromJson(json['response_payload'])
          : null,
      isSuccess: json['is_success'],
      errorMessage: json['error_message'],
      mlStatusCode: json['ml_status_code'],
      createdAt: json['created_at'],
    );
  }
}

class RequestPayload {
  final double? n, p, k, ph, ec, om;

  RequestPayload({
    this.n,
    this.p,
    this.k,
    this.ph,
    this.ec,
    this.om,
  });

  factory RequestPayload.fromJson(Map<String, dynamic> json) {
    return RequestPayload(
      n: (json['n'] as num?)?.toDouble(),
      p: (json['p'] as num?)?.toDouble(),
      k: (json['k'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      ec: (json['ec'] as num?)?.toDouble(),
      om: (json['om'] as num?)?.toDouble(),
    );
  }
}

class ResponsePayload {
  final String? color;
  final String? level;
  final String? nameEn;
  final String? nameAr;
  final List<Recommendations>? recommendations;
  final List<CropRecommendations>? cropRecommendations;
  final String? expertReportEn;
  final String? expertReportAr;

  ResponsePayload({
    this.color,
    this.level,
    this.nameEn,
    this.nameAr,
    this.recommendations,
    this.cropRecommendations,
    this.expertReportEn,
    this.expertReportAr,
  });

  factory ResponsePayload.fromJson(Map<String, dynamic> json) {
    return ResponsePayload(
      color: json['color'],
      level: json['level'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      expertReportEn: json['expert_report_en'],
      expertReportAr: json['expert_report_ar'],
      recommendations: (json['recommendations'] as List?)
          ?.map((e) => Recommendations.fromJson(e))
          .toList(),
      cropRecommendations: (json['crop_recommendations'] as List?)
          ?.map((e) => CropRecommendations.fromJson(e))
          .toList(),
    );
  }
}
