import 'seeds_database_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/userId_preferences.dart';
import '../exceptions.dart';

class SeedsDatabase {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), "seeds_system.db"),
      onCreate: (db, version) async => db.execute('CREATE TABLE seeds ('
          'id TEXT PRIMARY KEY NOT NULL,'
          'name TEXT NOT NULL,'
          'manufacturer TEXT NOT NULL,'
          'manufacturedAt TEXT NOT NULL,'
          'expiresIn TEXT NOT NULL,'
          'createdAt TEXT NOT NULL,'
          'createdBy TEXT NOT NULL,'
          'isSync INTEGER NOT NULL);'),
      version: 1,
    );
  }

  static Future<int> registerSeed(SeedsDatabaseModel seed) async {
    try {
      final db = await database();
      return await db.insert("seeds", seed.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      throw DbException();
    }
  }

  static Future<int> updateSeed(SeedsDatabaseModel seed) async {
    try {
      final db = await database();
      return await db.update("seeds", seed.toJson(),
          where: 'id=?',
          whereArgs: [seed.id],
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      throw DbException();
    }
  }

  static Future<int> deleteSeed(SeedsDatabaseModel seed) async {
    try {
      final db = await database();
      return await db.delete("seed", where: 'id=?', whereArgs: [seed.id]);
    } catch (error) {
      throw DbException();
    }
  }

  static Future<List<SeedsDatabaseModel>> getAllSeeds() async {
    try {
      final db = await database();
      String userId = await UserPreferences().getExternalUserId();
      final List<Map<String, dynamic>> list =
          await db.query("seeds", where: 'createdBy = ?', whereArgs: [userId]);
      return List.generate(
          list.length, (index) => SeedsDatabaseModel.fromJson(list[index]));
    } catch (error) {
      throw DbException();
    }
  }

  static Future<void> updateSyncFlag({required SeedsDatabaseModel seed}) async {
    try {
      final db = await database();
      await db.rawUpdate('UPDATE seeds SET isSync = 1 WHERE id = "${seed.id}"');
    } catch (error) {
      throw DbException();
    }
  }

  static Future<List<SeedsDatabaseModel>> getSeedsByName(
      {required String name}) async {
    try {
      final db = await database();
      String userId = await UserPreferences().getExternalUserId();
      final List<Map<String, dynamic>> list = await db.query(
        'seeds',
        where: 'name LIKE ? and createdBy LIKE ?',
        whereArgs: ['%$name%', userId],
      );
      return List.generate(
          list.length, (index) => SeedsDatabaseModel.fromJson(list[index]));
    } catch (error) {
      throw DbException();
    }
  }
}
