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

  Future<List<SeedsDatabaseModel>> getSeedsListByName(String seedName) async {
    final fetchedSeedsByName =
        await SeedsDatabase.getSeedsByName(name: seedName);
    return fetchedSeedsByName;
  }

  saveSeeds(Seeds seed) async {
    String id = const Uuid().v4().toString();
    String userId = await UserPreferences().getExternalUserId();

    await SeedsDatabase.registerSeed(
        SeedsDatabaseModel.fromSeed(seed, id, userId));
    return list;
  }

  syncSeeds(SeedsDatabaseModel seed) async {
    await SeedApiService.postSeeds(SeedsApiModel.fromDatabase(seed));
  }

  saveSeedsFromApi() async {
    String userId = await UserPreferences().getExternalUserId();
    List<SeedsApiModel> seeds = await SeedApiService.getRemoteSeeds(userId);
    for (int i = 0; i < seeds.length; i++) {
      await SeedsDatabase.registerSeed(
          SeedsDatabaseModel.fromApiSeed(seeds[i]));
    }
  }

  updateSyncFlag(SeedsDatabaseModel seed) async {
    await SeedsDatabase.updateSyncFlag(seed: seed);
    return list;
  }

  deleteSeed(SeedsDatabaseModel seed) async {
    await SeedsDatabase.deleteSeed(seed);
    return list;
  }

  updateSeed(SeedsDatabaseModel seed) async {
    await SeedsDatabase.updateSeed(seed);
    return list;
  }
}
