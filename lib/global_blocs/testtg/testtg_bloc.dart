import 'package:bloc/bloc.dart';

import 'testtg_event.dart';
import 'testtg_state.dart';

class TesttgBloc extends Bloc<TesttgEvent, TesttgState> {
  TesttgBloc() : super(TesttgState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<TesttgState> emit) async {
    emit(state.clone());
  }
}
