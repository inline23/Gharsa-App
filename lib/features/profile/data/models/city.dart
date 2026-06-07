class City {
  final int? id;
  final String? nameEn;
  final String? nameAr;

  City({
    this.id,
    this.nameEn,
    this.nameAr,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }
}