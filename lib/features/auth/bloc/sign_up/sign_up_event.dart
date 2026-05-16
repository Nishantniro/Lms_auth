part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent(this.signUpModel);
  final SignUpModel signUpModel;

  @override
  List<Object> get props => [signUpModel];
}
