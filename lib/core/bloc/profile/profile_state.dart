part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profileModel;

  const ProfileLoaded({required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}

final class ProfileFaliure extends ProfileState {
  final String msg;

  const ProfileFaliure({required this.msg});
  @override
  List<Object> get props => [msg];
}
