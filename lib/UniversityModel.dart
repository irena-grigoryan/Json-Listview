class UniversityModel {
  String? name;
  String? country;

  UniversityModel({
    this.name,
    this.country,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'],
      country: json['country'],
    );
  }
}
