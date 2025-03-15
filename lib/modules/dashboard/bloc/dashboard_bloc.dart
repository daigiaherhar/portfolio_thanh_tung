import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/dashboard_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';

import '../../../data/repository/api_service_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this.apiServiceRepository) : super(DashboardState().init()) {
    on<InitDashBoardEvent>(_init);
    on<ChangeTabBarEvent>(_changeTabBar);
  }

  final ApiServiceRepository apiServiceRepository;

  void _init(InitDashBoardEvent event, Emitter<DashboardState> emit) async {
    List<ProjectModel> listProject = [];
    List<ChartSkillModel> listSkill = [];
    try {


      listSkill = await apiServiceRepository.getSkill();
      listProject = await _readListProject();

      await Future.delayed(Duration(seconds: 1));

      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          listProject: listProject,
          listSkill: listSkill,
        ),
      );
    } catch (exception) {
      emit(
        state.copyWith(
          status: DashboardStatus.error,
          listProject: listProject,
          listSkill: listSkill,
          dashboardModel: DashboardModel(errorMessage: exception.toString()),
        ),
      );
    }
  }

  Future<List<ProjectModel>> _readListProject() async {
    List<ProjectModel> listProject = [];
    try {
      listProject = await apiServiceRepository.getProject();
      return listProject;
    } catch (exception) {
      rethrow;
    }
  }

  void _changeTabBar(
    ChangeTabBarEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // emit(state.copyWith(indexTab: event.position));
  }
}
