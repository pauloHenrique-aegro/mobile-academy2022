import '../../database/seeds_database_model.dart';

class SeedsStates {
  List<SeedsDatabaseModel> seeds;

  SeedsStates(this.seeds);
}

class EmptySeedsState extends SeedsStates {
  EmptySeedsState() : super([]);
}

class SomeSeedsState extends SeedsStates {
  SomeSeedsState(List<SeedsDatabaseModel> seeds) : super(seeds);
}

class GetSeedsFailureState extends SeedsStates {
  final String message;
  GetSeedsFailureState(this.message) : super([]);
}
