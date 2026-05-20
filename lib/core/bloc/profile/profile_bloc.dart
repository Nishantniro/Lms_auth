import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/data/repositories/profile_repositories.dart';
import 'package:lms/features/auth/model/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositories _profileRepositories = ProfileRepositories();
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(_getProfile);
  }
  Future<void> _getProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final data = await _profileRepositories.getProfile();

    data.fold(
      (l) => emit(ProfileFaliure(msg: l)),
      (r) => emit(ProfileLoaded(profileModel: r)),
    );
  }
}
