import '../database/database.dart';
import '../database/seeds_database_model.dart';
import '../models/seeds.dart';
import 'package:uuid/uuid.dart';
import '../utils/userId_preferences.dart';
import 'package:intl/intl.dart';

class SeedsRepository {
  final dateFormat = DateFormat('yyyy-MM-dd');
  List<SeedsDatabaseModel> list = [];

  Future<List<SeedsDatabaseModel>> getSeedsList() async {
    final fetchedSeeds = await SeedsDatabase.getAllSeeds();
    return fetchedSeeds;
  }

  saveSeeds(Seeds seed) async {
    String id = const Uuid().v4().toString();
    String userId = await UserIdPreferences().getExternalUserId();

    await SeedsDatabase.registerSeed(SeedsDatabaseModel(
        id: id,
        name: seed.name,
        manufacturer: seed.manufacturer,
        manufacturedAt: dateFormat.format(seed.manufacturedAt).toString(),
        expiresIn: dateFormat.format(seed.expiresIn).toString(),
        createdAt: DateTime.now().toIso8601String(),
        createdBy: userId,
        isSync: 0));
    return list;
  }
}
