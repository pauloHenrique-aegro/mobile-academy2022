import 'package:seeds_system/models/seeds.dart';
import 'package:seeds_system/network/seeds_api_model.dart';
import 'package:intl/intl.dart';

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

  factory SeedsDatabaseModel.fromApiSeed(SeedsApiModel seed) {
    return SeedsDatabaseModel(
        id: seed.id,
        name: seed.name,
        manufacturer: seed.manufacturer,
        manufacturedAt: seed.manufacturedAt,
        expiresIn: seed.expiresIn,
        createdAt: seed.createdAt,
        createdBy: seed.userId,
        isSync: 1);
  }

  factory SeedsDatabaseModel.fromSeed(Seeds seed, id, userId) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return SeedsDatabaseModel(
        id: id,
        name: seed.name,
        manufacturer: seed.manufacturer,
        manufacturedAt: dateFormat.format(seed.manufacturedAt).toString(),
        expiresIn: dateFormat.format(seed.expiresIn).toString(),
        createdAt: DateTime.now().toIso8601String(),
        createdBy: userId,
        isSync: 0);
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
