import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/data/repositories/profile_repositories.dart';
import 'package:lms/features/auth/model/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // final ProfileRepositories _profileRepositories = ProfileRepositories();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>(_getProfile);
  }
  Future<void> _getProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final ProfileRepositories profileRepositories = ProfileRepositories();

    emit(ProfileLoading());

    final data = await profileRepositories.getProfile();

    data.fold(
      (l) => emit(ProfileFaliure(msg: l)),
      (r) => emit(ProfileLoaded(profileModel: r)),
    );
  }
}
