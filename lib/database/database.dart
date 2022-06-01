import '../models/seeds.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SeedsDatabase {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), "seeds.db"),
      onCreate: (db, version) async => db.execute('CREATE TABLE seed ('
          'id TEXT,'
          'name TEXT,'
          'manufacturer TEXT,'
          'manufacturedAt TEXT,'
          'expiresIn TEXT,'
          'createdAt TEXT,'
          'createdBy TEXT,'
          'isSync INTEGER DEFAULT 0);'),
      version: 1,
    );
  }

  static Future<int> registerSeed(Seeds seed) async {
    final db = await database();
    return await db.insert("seed", seed.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateSeed(Seeds seed) async {
    final db = await database();
    return await db.update("seed", seed.toJson(),
        where: 'id=?',
        whereArgs: [seed.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteSeed(Seeds seed) async {
    final db = await database();
    return await db.delete("seed", where: 'id=?', whereArgs: [seed.id]);
  }

  static Future<List<Seeds>> getAllSeeds() async {
    final db = await database();
    final List<Map<String, dynamic>> list = await db.query("seed");
    return List.generate(list.length, (index) => Seeds.fromJson(list[index]));
  }
}
