
import '../models/dashboard_model.dart';
import '../models/index.dart';

enum DashboardStatus { init, loaded, error }

class DashboardState {
  final List<ProjectModel> listProject;
  final List<ChartSkillModel> listSkill;
  final List<SocialModel> listSocial;
  final DashboardStatus status;
  final DashboardModel? dashboardModel;

  DashboardState({
    this.listProject = const [],
    this.listSkill = const [],
    this.listSocial = const [],
    this.status = DashboardStatus.init,
    this.dashboardModel,
  });

  DashboardState init() {
    return DashboardState(
      status: DashboardStatus.init,
      listProject: [],
      listSkill: [],
      listSocial: [],
      dashboardModel: DashboardModel(),
    );
  }

  DashboardState clone() {
    return DashboardState();
  }

  DashboardState copyWith({
    DashboardStatus? status,
    List<ProjectModel>? listProject,
    List<ChartSkillModel>? listSkill,
    List<SocialModel>? listSocial,
    DashboardModel? dashboardModel,
  }) {
    return DashboardState(
      status: status ?? this.status,
      listProject: listProject ?? this.listProject,
      listSkill: listSkill ?? this.listSkill,
      listSocial: listSocial ?? this.listSocial,
      dashboardModel: dashboardModel ?? this.dashboardModel,
    );
  }
}
