import 'package:seeds_system/database/seeds_database_model.dart';

import '../../models/seeds.dart';

abstract class SeedsEvents {}

class LoadSeedsEvent extends SeedsEvents {}

class RegisterSeedEvent extends SeedsEvents {
  Seeds seed;

  RegisterSeedEvent(this.seed);
}

class DeleteSeedEvent extends SeedsEvents {
  SeedsDatabaseModel seed;

  DeleteSeedEvent(this.seed);
}
