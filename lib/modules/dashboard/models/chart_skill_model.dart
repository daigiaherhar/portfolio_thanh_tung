import 'package:flutter/cupertino.dart';

class ChartSkillModel {
  String? id;

  String? valueStart;
  String? valueCurrent;
  String? valueGoal;
  String? name;

  // GlobalKey key;

  ChartSkillModel({
    this.id,
    this.valueStart,
    this.valueCurrent,
    this.valueGoal,
    this.name,
    // required this.key,
  });

  ChartSkillModel.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      valueStart = json["valueStart"] ?? "0",
      valueCurrent = json["valueCurrent"] ?? "0",
      valueGoal = json["valueGoal"] ?? "0",
      name = json["name"] ?? "0";

  // key = GlobalKey()

  // List<ChartSkillModel>.fromList()=>
  List<ChartSkillModel> listJson(List<dynamic> list) {
    return list.map((e) => ChartSkillModel.fromJson(e)).toList();
  }

  // @override
  // String toString() {
  //   return 'ChallengePrivateModel{id: $id, nameChallenge: $nameChallenge, timeEndChallenge: $timeEndChallenge, time: $time, valueStart: $valueStart, valueCurrent: $valueCurrent, valueGoal: $valueGoal, timeEnd: $timeEnd, latest_weight_progress: $latest_weight_progress, valueProgress: $valueProgress}';
  // }
}
