part of 'apply_trainer_bloc.dart';

class ApplyTrainerEvent extends Equatable {
  const ApplyTrainerEvent(this.applyTrainerModel);
  final ApplyTrainerModel applyTrainerModel;

  @override
  List<Object> get props => [applyTrainerModel];
}
