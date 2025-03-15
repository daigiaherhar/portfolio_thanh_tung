import '../../modules/dashboard/models/chart_skill_model.dart';
import '../../modules/dashboard/models/project_model.dart';

abstract class RepositoryAdapter{
  Future<List<ChartSkillModel>> getSkill();
  Future<List<ProjectModel>> getProject();
}