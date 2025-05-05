import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
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
import '../../../global_widgets/container_smoke_widget.dart';
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
        mobile: BannerWidgetMobile(
          title: title,
          description: description,
          onTapDownCV: onTapDownCV,
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

class BannerWidgetMobile extends StatelessWidget {
  BannerWidgetMobile(
      {super.key, this.title, this.description, this.onTapDownCV});

  final String? title;
  final String? description;
  final ValueNotifier<bool> showDrawer = ValueNotifier(false);
  final ScrollController _scrollTabController = ScrollController();
  double widthTab = 0.0;
  final onTapDownCV;

  onDrawer() async {
    showDrawer.value = !showDrawer.value;
    return await _scrollTabController
        .animateTo(
          showDrawer.value ? widthTab : 0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    widthTab = width * .4;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollTabController,
        physics: NeverScrollableScrollPhysics(),
        child: ValueListenableBuilder<bool>(
            valueListenable: showDrawer,
            builder: (context, isDrawer, _) {
              return Row(
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: Matrix4.skewX(isDrawer ? -.1 : 0),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: ConstColors.black_1,
                                    image: DecorationImage(
                                        image: AssetImage(ConstImages.tung_2),
                                        fit: BoxFit.cover,
                                        opacity: 0.7)),
                                child: Stack(
                                  children: [
                                    TitleAndDescriptionWidget(
                                      sTitle: title,
                                      sDescription: description,
                                      sizeTile: 16,
                                      sizeDesc: 14,
                                    ),
                                    if (isDrawer)
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Text(
                                            "23423",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                  ],
                                ),
                              ).animate().moveX(begin: 20),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 50,
                          child: InkWell(
                            onTap: () => onDrawer(),
                            child: Container(
                              padding: ConstStyles.padding_5,
                              decoration: BoxDecoration(
                                  color: ConstColors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage(ConstImages.lightning),
                                  ),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20))),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: ConstColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isDrawer)
                    TabBarWidget(
                      width: widthTab,
                      onDrawer: onDrawer,
                      onTapDownCV: onTapDownCV,
                    )
                ],
              );
            }),
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget(
      {super.key, required this.width, this.onDrawer, this.onTapDownCV});

  final double width;
  final onDrawer;
  final onTapDownCV;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Transform(
          transform: Matrix4.skewX(-0.1),
          child: RainCustom(
            width: width + (200),
            height: height,
          ), // this wraps the previous Animate in another Animate
        ),
        Container(
          width: width,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          child: GestureDetector(
            onTap: () => onDrawer(),
            child: Stack(
              children: [
                Column(
                  children: [
                    _MoonCloudWidget(),
                    ContainerSmokeWidget(
                      onTap: () => onTapDownCV(),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      "23423",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RainCustom extends StatelessWidget {
  RainCustom({super.key, required this.width, required this.height});

  final double width;
  final double height;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return  Container(
            width: width,
            height: height,
            color: Colors.transparent,
            child: Stack(
              children: List.generate(20, (index) {
                final startX = random.nextDouble() * width;
                final duration = Duration(milliseconds: 500 + random.nextInt(800));

                return Positioned(
                  top: -10,
                  left: startX,
                  child: Container(
                    width: 2,
                    height: 50 + random.nextDouble() * 10,
                    color: ConstColors.yellow,
                  )
                      .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                      .moveY(begin: -10, end: height * 5, duration: duration)
                      .fadeIn(duration: 100.ms)
                      .fadeOut(duration: 200.ms),
                );
              }),
            ),
          ); // Hiện widget sau 1 giây
        } else {
          return SizedBox(); // Trống trong lúc chờ
        }

      },
    );
  }
}

class _MoonCloudWidget extends StatelessWidget {
  const _MoonCloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.3;
    final width = MediaQuery.of(context).size.width * 0.4;
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          _cloud(height, left: -40, top: height * .2),
          _cloud(height, right: -40, top: height * .07),
          SizedBox(
            height: height * .7,
            child: Image.asset(
              ConstImages.moon,
            ),
          ),
          _cloud(height, right: -40, top: height * .2),
          Image.asset(
            ConstImages.cloud_2,
          )
        ],
      ),
    );
  }

  Widget _cloud(double height, {double? top, double? left, double? right}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: SizedBox(
        height: height * 0.3,
        child: Image.asset(
          ConstImages.cloud,
        ),
      ),
    );
  }
}
