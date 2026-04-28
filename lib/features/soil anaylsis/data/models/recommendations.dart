class Recommendations {
  String? ar;
  String? en;
  String? priority;

  Recommendations({this.ar, this.en, this.priority});

  Recommendations.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
    priority = json['priority'];
  }
}
