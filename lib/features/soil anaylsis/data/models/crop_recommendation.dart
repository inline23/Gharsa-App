class CropRecommendations {
  String? cropEn;
  String? cropAr;
  String? seasonEn;
  String? seasonAr;
  int? suitability;
  String? reasonEn;
  String? reasonAr;

  CropRecommendations(
      {this.cropEn,
      this.cropAr,
      this.seasonEn,
      this.seasonAr,
      this.suitability,
      this.reasonEn,
      this.reasonAr});

  CropRecommendations.fromJson(Map<String, dynamic> json) {
    cropEn = json['crop_en'];
    cropAr = json['crop_ar'];
    seasonEn = json['season_en'];
    seasonAr = json['season_ar'];
    suitability = json['suitability'];
    reasonEn = json['reason_en'];
    reasonAr = json['reason_ar'];
  }

}