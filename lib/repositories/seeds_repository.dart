import '../database/database.dart';
import '../database/seeds_database_model.dart';
import '../models/seeds.dart';
import 'package:uuid/uuid.dart';
import '../utils/userId_preferences.dart';

class SeedsRepository {
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
        manufacturedAt: seed.manufacturedAt,
        expiresIn: seed.expiresIn,
        createdAt: DateTime.now().toString(),
        createdBy: userId,
        isSync: 0));
    return list;
  }
}
