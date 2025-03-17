import 'package:portfolio_thanh_tung/modules/dashboard/models/chart_skill_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/project_model.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/social_model.dart';

import '../../constants/constants.dart';
import '../adapter/repository_adapter.dart';
import 'package:http/http.dart' as http;

import '../provider/rest.dart';

class ApiServiceRepository extends RestAPIClient implements RepositoryAdapter {
  // var client = http.Client();

  @override
  Future<List<ChartSkillModel>> getSkill() async {
    try {
      List<ChartSkillModel> list = [];
      // TODO: implement getSkill
      // var url = Uri.https(CommonString.BASEURL, 'portfolio/list_skill.json');
      List response = await get("list_skill.json");
      // print("response");
      // print(response.runtimeType);
      // print(response);
      // response.forEach((element) => print("eeeeeeee $element"),);

      list = response.map((json) => ChartSkillModel.fromJson(json)).toList();

      return list;
    } catch (exception) {
      print("error getSkill");
    }

    throw UnimplementedError();
  }

  @override
  Future<List<ProjectModel>> getProject() async {
    try {
      List<ProjectModel> list = [];
      // TODO: implement getSkill
      // var url = Uri.https(CommonString.BASEURL, 'portfolio/list_skill.json');
      List response = await get("list_project.json");
      print("responseresponse");
      print(response.runtimeType);
      print(response);
      // response.forEach((element) => print("eeeeeeee $element"),);

      list = response.map((json) => ProjectModel.fromJson(json)).toList();

      return list;
    } catch (exception) {
      throw exception;
    }
  }

  @override
  Future<List<SocialModel>> getSocial() async {
    try {
      List<SocialModel> list = [];
      // TODO: implement getSkill
      // var url = Uri.https(CommonString.BASEURL, 'portfolio/list_skill.json');
      List response = await get("list_social.json");
      // response.forEach((element) => print("eeeeeeee $element"),);


      list = response.map((json) => SocialModel.fromJson(json)).toList();

      return list;
    } catch (exception) {
      throw exception;
    }
  }
}
