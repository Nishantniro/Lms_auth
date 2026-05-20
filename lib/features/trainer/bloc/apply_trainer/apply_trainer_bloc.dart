import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/trainer/model/apply_trainer_model.dart';
import 'package:lms/features/trainer/repositories/trainer_repositories.dart';

part 'apply_trainer_event.dart';
part 'apply_trainer_state.dart';

class ApplyTrainerBloc extends Bloc<ApplyTrainerEvent, ApplyTrainerState> {
  ApplyTrainerBloc() : super(ApplyTrainerInitial()) {
    final TrainerRepositories repositories = TrainerRepositories();

    on<ApplyTrainerEvent>((event, emit) async {
      emit(ApplyTrainerLoading());
      final result = await repositories.applyForTrainer(
        event.applyTrainerModel,
      );
      result.fold(
        (l) => emit(ApplyTrainerFailure(msg: l)),
        (r) => emit(ApplyTrainerLoaded()),
      );
    });
  }
}
