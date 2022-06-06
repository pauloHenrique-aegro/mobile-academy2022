import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:seeds_system/exceptions.dart';
import '../seeds_bloc/seeds_event.dart';
import '../seeds_bloc/seeds_state.dart';
import '../../repositories/seeds_repository.dart';

class SeedsBloc extends Bloc<SeedsEvents, SeedsStates> {
  final _repo = SeedsRepository();

  SeedsBloc() : super(EmptySeedsState()) {
    on<LoadSeedsEvent>((event, emit) async {
      emit(LoadingSeedsState());
      await Future.delayed(const Duration(seconds: 1));
      await _repo.getSeedsList().then((seeds) => emit(SomeSeedsState(seeds)));
    });

    on<RegisterSeedEvent>((event, emit) async {
      try {
        await _repo
            .saveSeeds(event.seed)
            .then((seeds) => emit(SomeSeedsState(seeds)));
        emit(SaveSeedsSuccessState());
      } on DbException catch (e) {
        emit(SaveSeedsFailureState(e));
      }
    });

    on<SyncSeedEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      try {
        await _repo.syncSeeds(event.seed);
        await _repo.updateSyncFlag(event.seed);
        emit(SyncSeedsSuccessState());
      } on Exception catch (e) {
        emit(SyncSeedsFailureState(e));
      }
    });

    on<LoadApiSeedsEvent>((event, emit) async {
      await _repo.saveSeedsFromApi();
    });

    on<LoadSearchEvent>((event, emit) async {
      emit(LoadingSeedsState());
      await _repo
          .getSeedsListByName(event.query)
          .then((seeds) => emit(SomeSeedsState(seeds)));
    });

    on<UpdateSeedEvent>((event, emit) async {
      try {
        await _repo
            .updateSeed(event.seed)
            .then((seeds) => emit(SomeSeedsState(seeds)));
        emit(UpdateSeedsSuccessState());
      } on DbException catch (e) {
        emit(UpdateSeedsFailureState(e));
      }
    });

    on<DeleteSeedEvent>((event, emit) async {
      try {
        await _repo
            .deleteSeed(event.seed)
            .then((seeds) => emit(SomeSeedsState(seeds)));
        emit(DeleteSeedsSuccessState());
      } on DbException catch (e) {
        emit(DeleteSeedsFailureState(e));
      }
    });
  }
}
