import 'package:flutter/cupertino.dart';

class TabBarCustomModel {
  final int id;
  final String? title;
  final String? logo;
  final String? html;
  final GlobalKey? key;

  const TabBarCustomModel({
    required this.id,
    this.title,
    this.html,
    this.logo,
    this.key,
  });
}
