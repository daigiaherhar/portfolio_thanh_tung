import 'package:bloc/bloc.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState().init()) {
    on<InitDashBoardEvent>(_init);
    on<ChangeTabBarEvent>(_changeTabBar);
  }

  void _init(InitDashBoardEvent event, Emitter<DashboardState> emit) async {
    List<TabBarCustomModel> listProject = [];
    listProject.add(TabBarCustomModel(id: 0, title: "TRMe"));
    listProject.add(TabBarCustomModel(id: 1, title: "Warranty"));
    listProject.add(TabBarCustomModel(id: 2, title: "Office"));
    // listProject.add(TabBarCustomModel(id: 3, title: "4"));
    // listProject.add(TabBarCustomModel(id: 4, title: "5"));
    // listProject.add(TabBarCustomModel(id: 5, title: "6"));

    print("InitDashBoardEvent");
    print("testttttt");
    print(listProject.length);
    print(listProject.length);
    // emit(state.clone());
    emit(state.copyWith(listProject: listProject, indexTab: 1));
  }

  void _changeTabBar(
    ChangeTabBarEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(indexTab: event.position));
  }
}
