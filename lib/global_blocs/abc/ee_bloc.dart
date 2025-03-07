import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ee_event.dart';
part 'ee_state.dart';

class EeBloc extends Bloc<EeEvent, EeState> {
  EeBloc() : super(EeInitial()) {
    on<EeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
