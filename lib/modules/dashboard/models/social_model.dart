class SocialModel {
  String? id;
  String? name;
  String? logo;
  String? link;

  SocialModel({this.id, this.name, this.logo, this.link});

  SocialModel.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      name = json["title"].toString(),
      logo = json["logo"] ?? "",
      link = json["link"] ?? "";
}
