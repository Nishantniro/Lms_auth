part of 'trainer_profile_bloc.dart';

sealed class TrainerProfileState extends Equatable {
  const TrainerProfileState();

  @override
  List<Object> get props => [];
}

final class TrainerProfileInitial extends TrainerProfileState {}

final class TrainerProfileLoading extends TrainerProfileState {}

final class TrainerProfileLoaded extends TrainerProfileState {
  final TrainerProfileModel profileModel;

  const TrainerProfileLoaded({required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}

final class TrainerProfileFailure extends TrainerProfileState {
  final String msg;

  const TrainerProfileFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
