import 'package:bloc/bloc.dart';
import '../seeds_bloc/seeds_event.dart';
import '../seeds_bloc/seeds_state.dart';
import '../../repositories/seeds_repository.dart';

class SeedsBloc extends Bloc<SeedsEvents, SeedsStates> {
  final _repo = SeedsRepository();

  SeedsBloc() : super(EmptySeedsState()) {
    on<LoadSeedsEvent>((event, emit) async {
      await _repo.getSeedsList().then((seeds) => emit(SomeSeedsState(seeds)));
    });

    on<RegisterSeedEvent>((event, emit) async {
      await _repo
          .saveSeeds(event.seed)
          .then((seeds) => emit(SomeSeedsState(seeds)));
    });

    /*on<DeleteSeedEvent>(
        (event, emit) => emit(SomeSeedsState(_repo.deleteSeeds(event.seed))));*/
  }
}
