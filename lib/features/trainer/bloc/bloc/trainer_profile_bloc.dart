import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/trainer/model/trainer_profile_model.dart';
import 'package:lms/features/trainer/repositories/trainer_repositories.dart';

part 'trainer_profile_event.dart';
part 'trainer_profile_state.dart';

class TrainerProfileBloc
    extends Bloc<TrainerProfileEvent, TrainerProfileState> {
  final TrainerRepositories _repositories = TrainerRepositories();
  TrainerProfileBloc() : super(TrainerProfileInitial()) {
    on<TrainerProfileEvent>((event, emit) async {
      emit(TrainerProfileLoading());
      final result = await _repositories.gettrainerProfile();
      result.fold(
        (l) => emit(TrainerProfileFailure(msg: l)),
        (r) => emit(TrainerProfileLoaded(profileModel: r)),
      );
    });
  }
}
