import 'package:gharsa_app/features/soil%20anaylsis/data/models/recommendations.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/crop_recommendation.dart';

class SoilAnalysisModel {
  bool? success;
  String? message;
  Data? data;

  SoilAnalysisModel({this.success, this.message, this.data});

  SoilAnalysisModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? clusterId;
  String? nameEn;
  String? nameAr;
  String? level;
  String? color;
  List<Recommendations>? recommendations;
  List<CropRecommendations>? cropRecommendations;
  String? expertReportAr;
  String? expertReportEn;

  Data({
    this.clusterId,
    this.nameEn,
    this.nameAr,
    this.level,
    this.color,
    this.recommendations,
    this.cropRecommendations,
    this.expertReportAr,
    this.expertReportEn,
  });

  Data.fromJson(Map<String, dynamic> json) {
    clusterId = json['cluster_id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    level = json['level'];
    color = json['color'];
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(new Recommendations.fromJson(v));
      });
    }
    if (json['crop_recommendations'] != null) {
      cropRecommendations = <CropRecommendations>[];
      json['crop_recommendations'].forEach((v) {
        cropRecommendations!.add(new CropRecommendations.fromJson(v));
      });
    }
    expertReportAr = json['expert_report_ar'];
    expertReportEn = json['expert_report_en'];
  }
}
