import '../models/index.dart';

class DashboardState {
  final List<TabBarCustomModel> listProject;
  final int indexTab;

  DashboardState({this.listProject = const [], this.indexTab = 0});

  DashboardState init() {
    return DashboardState(indexTab: 0, listProject: []);
  }

  DashboardState clone() {
    return DashboardState();
  }

  DashboardState copyWith({
    int? indexTab,
    List<TabBarCustomModel>? listProject,
  }) {
    return DashboardState(
      indexTab: indexTab ?? this.indexTab,
      listProject: listProject ?? this.listProject,
    );
  }
}
