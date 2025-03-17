import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';

import '../../modules/dashboard/models/chart_skill_model.dart';
import '../../modules/dashboard/models/project_model.dart';

abstract class RepositoryAdapter{
  Future<List<ChartSkillModel>> getSkill();
  Future<List<ProjectModel>> getProject();
  Future<List<SocialModel>> getSocial();
}