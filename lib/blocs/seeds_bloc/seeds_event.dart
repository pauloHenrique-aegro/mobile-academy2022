import 'package:seeds_system/database/seeds_database_model.dart';

import '../../models/seeds.dart';

abstract class SeedsEvents {
  SeedsEvents();
}

class LoadSeedsEvent extends SeedsEvents {}

class RegisterSeedEvent extends SeedsEvents {
  Seeds seed;

  RegisterSeedEvent(this.seed);
}

class UpdateSeedEvent extends SeedsEvents {
  SeedsDatabaseModel seed;

  UpdateSeedEvent(this.seed);
}

class DeleteSeedEvent extends SeedsEvents {
  SeedsDatabaseModel seed;

  DeleteSeedEvent(this.seed);
}

class SyncSeedEvent extends SeedsEvents {
  SeedsDatabaseModel seed;

  SyncSeedEvent(this.seed);
}

class LoadApiSeedsEvent extends SeedsEvents {}

class LoadSearchEvent extends SeedsEvents {
  String query;

  LoadSearchEvent({required this.query});
}
