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

  factory SeedsDatabaseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return SeedsDatabaseModel(
      id: json['id'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      manufacturedAt: json['manufacturedAt'],
      expiresIn: json['expiresIn'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      isSync: json['isSync'],
    );
  }

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
