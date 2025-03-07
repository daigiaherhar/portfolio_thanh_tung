import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:portfolio_thanh_tung/models/language_model.dart';

import '../../../constants/constants.dart';
import '../../../global_blocs/language/language_cubit.dart';
import '../../../global_blocs/language/language_state.dart';
import '../../../global_widgets/global_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageAdapter extends StatelessWidget {
  LanguageAdapter({
    super.key,
    required this.lang,
    this.onTap,
    this.colorHoverOriginal,
    this.enterHover,
    this.exitHover,
    // required this.languageModel,
  });

  final String lang;
  final onTap;
  final enterHover;
  final exitHover;
  final Color? colorHoverOriginal;

  String handleLangName(BuildContext context) {
    // context.read<LanguageCubit>().getStatus();
    print("vi3333333333333333333333333");
    print(lang);
    if (lang == LanguageStatus.vi.name) {

      return FlutterI18n.translate(context, "dashboard.vi");
    } else if (lang == LanguageStatus.en.name) {
      return FlutterI18n.translate(context, "dashboard.en");
    }
    return FlutterI18n.translate(context, "dashboard.en");
  }

  String handleLangImage(BuildContext context) {
    FlutterI18n.currentLocale(context);
    if (lang == LanguageStatus.vi.name) {
      return ConstImages.icon_vi;
    } else if (lang == LanguageStatus.en.name) {
      return ConstImages.icon_en;
    }
    return ConstImages.icon_en;
  }

  @override
  Widget build(BuildContext context) {
    return OnHoverColor(
      onTap: onTap,
      enterHover: enterHover,
      // exitHover: exitHover,
      margin: ConstStyles.padding_5,
      padding: EdgeInsets.zero,
      color: colorHoverOriginal ?? ConstColors.background,
      colorHover: ConstColors.orange,
      child: Container(
        padding: ConstStyles.padding_10,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(handleLangImage(context), height: 24, width: 24),
            ConstStyles.space_w_5,
            Text(
              handleLangName(context),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
