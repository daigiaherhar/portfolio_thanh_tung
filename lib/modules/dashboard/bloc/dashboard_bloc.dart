import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/dashboard_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';

import '../../../data/repositories/api_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this.apiServiceRepository) : super(DashboardState().init()) {
    on<InitDashBoardEvent>(_init);
    on<ChangeTabBarEvent>(_changeTabBar);
    on<DownCVEvent>(_downCVEvent);
  }

  final ApiServiceRepository apiServiceRepository;

  void _init(InitDashBoardEvent event, Emitter<DashboardState> emit) async {
    List<ProjectModel> listProject = [];
    List<ChartSkillModel> listSkill = [];
    List<SocialModel> listSocial = [];
    try {
      listSkill = await apiServiceRepository.getSkill();
      listSocial = await apiServiceRepository.getSocial();
      listProject = await _readListProject();

      await Future.delayed(Duration(seconds: 1));

      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          listProject: listProject,
          listSocial: listSocial,
          listSkill: listSkill,
        ),
      );
    } catch (exception) {
      emit(
        state.copyWith(
          status: DashboardStatus.error,
          listProject: listProject,
          listSkill: listSkill,
          listSocial: listSocial,
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

  void _downCVEvent(
    DownCVEvent event,
    Emitter<DashboardState> emit,
  ) async {
    await apiServiceRepository.downFileUri(Uri.parse("uri"));
  }
}
