import '../database/database.dart';
import '../database/seeds_database_model.dart';
import '../models/seeds.dart';
import 'package:uuid/uuid.dart';

class SeedsRepository {
  List<SeedsDatabaseModel> list = [];

  Future<List<SeedsDatabaseModel>> getSeedsList() async {
    final fetchedSeeds = await SeedsDatabase.getAllSeeds();
    print(fetchedSeeds);
    return fetchedSeeds;
  }

  saveSeeds(Seeds seed) async {
    String id = const Uuid().v4().toString();
    print(seed);

    await SeedsDatabase.registerSeed(SeedsDatabaseModel(
        id: id,
        name: seed.name,
        manufacturer: seed.manufacturer,
        manufacturedAt: seed.manufacturedAt,
        expiresIn: seed.expiresIn,
        createdAt: DateTime.now().toString(),
        createdBy: "UserTest",
        isSync: 0));
    return list;
  }
}
