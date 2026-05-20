part of 'login_bloc.dart';

 class LoginEvent extends Equatable {
  const LoginEvent({required this.loginModel});
  final LoginModel loginModel;

  @override
  List<Object> get props => [loginModel];
}
