import 'package:seeds_system/network/seeds_api_model.dart';
import 'package:seeds_system/network/seeds_service.dart';

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

  syncSeeds(SeedsDatabaseModel seed) async {
    await SeedApiService().postSeeds(seed.id, seed.name, seed.manufacturer,
        seed.manufacturedAt, seed.expiresIn, seed.createdAt, seed.createdBy);
  }

  saveSeedsFromApi() async {
    String userId = await UserIdPreferences().getExternalUserId();
    List<SeedsApiModel> seeds = await SeedApiService().getRemoteSeeds(userId);
    for (int i = 0; i < seeds.length; i++) {
      await SeedsDatabase.registerSeed(SeedsDatabaseModel(
          id: seeds[i].id,
          name: seeds[i].name,
          manufacturer: seeds[i].manufacturer,
          manufacturedAt: seeds[i].manufacturedAt,
          expiresIn: seeds[i].expiresIn,
          createdAt: seeds[i].createdAt,
          createdBy: seeds[i].userId,
          isSync: 1));
    }
  }

  updateSyncFlag(SeedsDatabaseModel seed) async {
    await SeedsDatabase.updateSyncFlag(seed: seed);
  }
}
