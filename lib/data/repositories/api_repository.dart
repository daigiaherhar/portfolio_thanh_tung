import 'package:portfolio_thanh_tung/modules/dashboard/models/chart_skill_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/project_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/social_model.dart';

abstract class ApiServiceRepository {
  Future<List<ChartSkillModel>> getSkill();

  Future<List<ProjectModel>> getProject();

  Future<List<SocialModel>> getSocial();

  Future downFileUri(Uri uri);
}
