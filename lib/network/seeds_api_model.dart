import 'package:seeds_system/database/seeds_database_model.dart';

class SeedsApiModel {
  String id;
  String name;
  String manufacturer;
  String manufacturedAt;
  String expiresIn;
  String createdAt;
  String userId;

  SeedsApiModel(
      {required this.id,
      required this.name,
      required this.manufacturer,
      required this.manufacturedAt,
      required this.expiresIn,
      required this.createdAt,
      required this.userId});

  factory SeedsApiModel.fromJson(Map<String, dynamic> json) {
    return SeedsApiModel(
      id: json['id'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      manufacturedAt: json['manufacturedAt'],
      expiresIn: json['expiresIn'],
      createdAt: json['createdAt'],
      userId: json['userId'],
    );
  }

  factory SeedsApiModel.from(SeedsDatabaseModel seed) {
    return SeedsApiModel(
        id: seed.id,
        name: seed.name,
        manufacturer: seed.manufacturer,
        manufacturedAt: seed.manufacturedAt,
        expiresIn: seed.expiresIn,
        createdAt: seed.createdAt,
        userId: seed.createdBy);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'manufacturer': manufacturer,
        'manufacturedAt': manufacturedAt,
        'expiresIn': expiresIn,
        'createdAt': createdAt,
        'userId': userId,
      };
}
