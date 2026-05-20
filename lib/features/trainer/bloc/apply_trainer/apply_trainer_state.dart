part of 'apply_trainer_bloc.dart';

sealed class ApplyTrainerState extends Equatable {
  const ApplyTrainerState();

  @override
  List<Object> get props => [];
}

final class ApplyTrainerInitial extends ApplyTrainerState {}

final class ApplyTrainerLoading extends ApplyTrainerState {}

final class ApplyTrainerLoaded extends ApplyTrainerState {}

final class ApplyTrainerFailure extends ApplyTrainerState {
  final String msg;

  const ApplyTrainerFailure({required this.msg});
  @override
  List<Object> get props => [msg];
}
