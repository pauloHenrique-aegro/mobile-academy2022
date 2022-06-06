import '../../database/seeds_database_model.dart';

class SeedsStates {
  List<SeedsDatabaseModel> seeds;

  SeedsStates(this.seeds);
}

class LoadingSeedsState extends SeedsStates {
  LoadingSeedsState() : super([]);
}

class EmptySeedsState extends SeedsStates {
  EmptySeedsState() : super([]);
}

class SomeSeedsState extends SeedsStates {
  SomeSeedsState(List<SeedsDatabaseModel> seeds) : super(seeds);
}

class SyncSeedsFailureState extends SeedsStates {
  final Exception exception;
  SyncSeedsFailureState(this.exception) : super([]);
}

class GetSeedsFailureState extends SeedsStates {
  final Exception exception;
  GetSeedsFailureState(this.exception) : super([]);
}
