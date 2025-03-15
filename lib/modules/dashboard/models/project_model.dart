import 'package:flutter/cupertino.dart';

class ProjectModel {
  String? id;
  GlobalKey key;
  String? name;
  String logo;
  Map<String, dynamic>? html;

  ProjectModel({
    this.id,
    this.name,
    this.logo = "",
    required this.key,
    this.html,
  });

  ProjectModel.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      key = GlobalKey(),
      name = json["title"].toString(),
      logo = json["logo"] ?? "",
      html = json["html"] ?? {};
}
