import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_thanh_tung/global_blocs/language/language_cubit.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/models/index.dart';
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
  });

  final String? title;
  final String? description;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  late GlobalKey popupLang = GlobalKey();
  final List<SocialModel>? listSocial;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: AllImage()),

        Positioned.fill(child: Container(color: ConstColors.black_1)),

        Positioned(
          left: 0,
          top: height * .2,
          width: width / 2,
          child: TitleAndDescriptionWidget(
            sTitle: title,
            sDescription: description,
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: LanguageWidget(popupLang: popupLang),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          child: _SocialWidget(listSocial: listSocial),
        ),
      ],
    );
  }
}

class AllImage extends StatelessWidget {
  const AllImage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * .9;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Row(
        children: [
          Container(
            width: width * .35,
            child: Image.asset(
              ConstImages.tung_1,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
          ).animate().fade(duration: 500.ms).moveX(begin: -width * .25, end: 0),
          Container(
            width: width * .3,
            child: Column(
              children: [
                Container(
                      // margin: EdgeInsets.all(15),
                      height: height / 2,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: ConstColors.white),
                          left: BorderSide(color: ConstColors.white, width: 2),
                          right: BorderSide(color: ConstColors.white, width: 2),
                        ),
                      ),
                      child: Image.asset(
                        ConstImages.tung_4,
                        fit: BoxFit.cover,
                        height: height,
                        width: width,
                      ),
                    )
                    .animate()
                    .fade() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .moveY(delay: 300.ms, duration: 500.ms, begin: -20),

                // runs after the above w/new duration
                Container(
                      // margin: EdgeInsets.all(15),
                      height: height / 2,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: ConstColors.white),
                          left: BorderSide(color: ConstColors.white, width: 2),
                          right: BorderSide(color: ConstColors.white, width: 2),
                        ),
                      ),
                      child: Image.asset(
                        ConstImages.tung_3,
                        fit: BoxFit.cover,
                        height: height,
                        width: width,
                      ),
                    )
                    .animate()
                    .fade() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .moveY(delay: 300.ms, duration: 500.ms, begin: 20),

                // runs after the above w/new duration
              ],
            ),
          ),
          Container(
            width: width * .35,
            child: Image.asset(
              ConstImages.tung_2,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
          ).animate().fade(duration: 500.ms).moveX(begin: width * .25, end: 0),
        ],
      ),
    );
  }
}

class TitleAndDescriptionWidget extends StatelessWidget {
  const TitleAndDescriptionWidget({super.key, this.sTitle, this.sDescription});

  final String? sTitle;
  final String? sDescription;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            // color: ConstColors.black_1,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    sTitle ?? "",
                    style: GoogleFonts.aDLaMDisplay(
                      color: ConstColors.white,
                      fontSize: ConstStyles.fontTitle(width),
                      height: 1,
                      letterSpacing: -1,
                    ),
                    textAlign: TextAlign.left,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: ConstColors.orange)
                  .animate() // this wraps the previous Animate in another Animate
                  .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                  .slide(),
              ConstStyles.space_15,
              Text(
                sDescription ?? "",
                style: TextStyle(
                  color: ConstColors.black_5,
                  fontSize: ConstStyles.fontDescription(width),
                  height: 1,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        )
        .animate()
        .scale(delay: 800.ms, duration: 800.ms)
        .moveY(end: 0, begin: -height * 0.25, delay: 500.ms);
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key, required this.popupLang});

  final GlobalKey popupLang;

  LanguageStatus swapChangeLang(BuildContext context) {
    LanguageStatus lang = LanguageStatus.en;
    FlutterI18n.currentLocale(context)!.languageCode == "en"
        ? lang = LanguageStatus.vi
        : lang = LanguageStatus.en;
    return lang;
  }

  handleChangeLang(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);

    context.read<LanguageCubit>().changeLanguage(swapChangeLang(context));
  }

  onTapLang(context) {
    print("onTapLangonTapLangonTapLang");
    RenderBox renderBox =
        popupLang.currentContext!.findRenderObject()! as RenderBox;
    final tapLocationOffset = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(seconds: 0),
        pageBuilder: (context, animation1, animation2) {
          return OverPopupPage(
            showOffset: tapLocationOffset,
            buttonSize: buttonSize,

            widget: LanguageAdapter(
              onTap: () async => handleChangeLang(context),
              lang: swapChangeLang(context).name,
              colorHoverOriginal: Colors.transparent,
            ),
          );
        },
      ),
    );
  }

  exitHover(context) {
    Navigator.canPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LanguageAdapter(
      key: popupLang,
      onTap: () => onTapLang(context),
      enterHover: () => onTapLang(context),
      // exitHover: () => exitHover(context),
      lang: FlutterI18n.currentLocale(context)!.languageCode,
    );
  }
}

class _SocialWidget extends StatelessWidget {
  _SocialWidget({super.key, this.listSocial});

  List<SocialModel>? listSocial;

  @override
  Widget build(BuildContext context) {
    print("listSocial");
    print(listSocial);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(listSocial?.length ?? 0, (index) {
                SocialModel data = listSocial![index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => launchUrlString(data.link.toString()),
                    child: Image.network(
                      data.logo ?? "",
                      height: 24,
                      width: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error_outline_sharp,
                          color: ConstColors.red,
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FlutterI18n.translate(context, "mail"),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SelectableText(
                  FlutterI18n.translate(context, "mail_value"),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FlutterI18n.translate(context, "phone"),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SelectableText(
                FlutterI18n.translate(context, "phone_value"),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
