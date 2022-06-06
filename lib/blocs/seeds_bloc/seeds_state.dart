import 'package:seeds_system/exceptions.dart';

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

class SaveSeedsSuccessState extends SeedsStates {
  SaveSeedsSuccessState() : super([]);
}

class SaveSeedsFailureState extends SeedsStates {
  final Exception exception;
  SaveSeedsFailureState(this.exception) : super([]);
}

class SyncSeedsSuccessState extends SeedsStates {
  SyncSeedsSuccessState() : super([]);
}

class SyncSeedsFailureState extends SeedsStates {
  final Exception exception;
  SyncSeedsFailureState(this.exception) : super([]);
}

class GetSeedsFailureState extends SeedsStates {
  final Exception exception;
  GetSeedsFailureState(this.exception) : super([]);
}

class DeleteSeedsSuccessState extends SeedsStates {
  DeleteSeedsSuccessState() : super([]);
}

class DeleteSeedsFailureState extends SeedsStates {
  final DbException exception;
  DeleteSeedsFailureState(this.exception) : super([]);
}

class UpdateSeedsSuccessState extends SeedsStates {
  UpdateSeedsSuccessState() : super([]);
}

class UpdateSeedsFailureState extends SeedsStates {
  final Exception exception;
  UpdateSeedsFailureState(this.exception) : super([]);
}
