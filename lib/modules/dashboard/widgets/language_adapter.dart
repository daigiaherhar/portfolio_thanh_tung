import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class LanguageAdapter extends StatelessWidget {
  const LanguageAdapter({super.key, required this.sImage, required this.sName});

  final String sName;
  final String sImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(sImage, height: 24, width: 24),
        ConstStyles.space_w_5,
        Text(sName, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
