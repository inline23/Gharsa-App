import 'package:gharsa_app/features/soil%20anaylsis/data/models/recommendations.dart';

class SoilData {
  final int clusterId;
  final String nameEn;
  final String nameAr;
  final String level;
  final String color;
  final List<Recommendations> recommendations;

  SoilData({
    required this.clusterId,
    required this.nameEn,
    required this.nameAr,
    required this.level,
    required this.color,
    required this.recommendations,
  });

  factory SoilData.fromJson(Map<String, dynamic> json) {
    return SoilData(
      clusterId: json['cluster_id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      level: json['level'],
      color: json['color'],
      recommendations: (json['recommendations'] as List)
          .map((e) => Recommendations.fromJson(e))
          .toList(),
    );
  }
}