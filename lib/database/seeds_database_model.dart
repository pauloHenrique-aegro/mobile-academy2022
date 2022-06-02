class SeedsDatabaseModel {
  String id;
  String name;
  String manufacturer;
  String manufacturedAt;
  String expiresIn;
  String createdAt;
  String createdBy;
  int? isSync;

  SeedsDatabaseModel(
      {required this.id,
      required this.name,
      required this.manufacturer,
      required this.manufacturedAt,
      required this.expiresIn,
      required this.createdAt,
      required this.createdBy,
      required this.isSync});

  factory SeedsDatabaseModel.fromJson(Map<String, dynamic> json) =>
      SeedsDatabaseModel(
        id: json['id'] as String,
        name: json['name'] as String,
        manufacturer: json['manufacturer'] as String,
        manufacturedAt: json['manufacturedAt'] as String,
        expiresIn: json['expiresIn'] as String,
        createdAt: json['createdAt'] as String,
        createdBy: json['createBy'] as String,
        isSync: json['isSync'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'manufacturer': manufacturer,
        'manufacturedAt': manufacturedAt,
        'expiresIn': expiresIn,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'isSync': isSync,
      };
}
