import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_thanh_tung/global_blocs/language/language_cubit.dart';
import 'package:portfolio_thanh_tung/global_widgets/responsive_widget.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/banner_widget_web.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/title_and_description.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_blocs/language/language_state.dart';
import '../../../global_widgets/global_widgets.dart';
import 'index.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({
    super.key,
    this.title,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.listSocial,
    this.onTapDownCV,
  });

  final String? title;
  final String? description;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  late GlobalKey popupLang = GlobalKey();
  final List<SocialModel>? listSocial;
  final onTapDownCV;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ResponsiveWidget(
        mobile: SafeArea(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ConstImages.tung_2),
                            fit: BoxFit.cover,
                            opacity: 0.7)),
                    child: TitleAndDescriptionWidget(
                      sTitle: title,
                      sDescription: description,
                      sizeTile: 16,
                      sizeDesc: 14,
                    ),
                  )),
                  // Center(
                  //   child: Container(
                  //     color: Colors.red,
                  //     height: double.infinity,
                  //     width: 50,
                  //     child: Text("55"),
                  //   ),
                  // ),
                ],
              ),
              Positioned(
                right: 0,
                top: 50,
                child: Container(
                  color: Colors.red,
                  child: Text("<<<<<<<<<<55>>>>>>>>>>"),
                ),
              ),
            ],
          ),
        ),
        web: BannerWebWidget(
          title: FlutterI18n.translate(context, "dashboard.name"),
          description: FlutterI18n.translate(
            context,
            "dashboard.description",
          ),
          listSocial: listSocial,
          onTapDownCV: onTapDownCV,
        ));
  }
}
