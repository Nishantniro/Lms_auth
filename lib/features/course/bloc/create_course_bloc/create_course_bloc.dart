import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_course_event.dart';
part 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  CreateCourseBloc() : super(CreateCourseInitial()) {
    on<CreateCourseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
