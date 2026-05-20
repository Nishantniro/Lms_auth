import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/auth/model/login_model.dart';
import 'package:lms/features/auth/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository = AuthRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final data = await _repository.login(login: event.loginModel);
      data.fold(
        (l) => emit(LoginFailure(msg: l)),
        (r) => emit(LoginLoaded(msg: r)),
      );
    });
  }
}
