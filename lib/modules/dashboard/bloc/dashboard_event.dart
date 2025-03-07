abstract class DashboardEvent {}

class InitDashBoardEvent extends DashboardEvent {}

class ChangeTabBarEvent extends DashboardEvent {
  int position;

  ChangeTabBarEvent({required this.position});
}
