import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/constants.dart';

class TitleAndDescriptionWidget extends StatelessWidget {
  const TitleAndDescriptionWidget(
      {super.key,
      this.sTitle,
      this.sDescription,
      this.sizeDesc,
      this.sizeTile});

  final String? sTitle;
  final String? sDescription;
  final double? sizeTile;
  final double? sizeDesc;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sTitle ?? "",
            style: GoogleFonts.aDLaMDisplay(
              color: ConstColors.white,
              fontSize: sizeTile ?? ConstStyles.fontTitle(width),
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
              fontSize: sizeDesc ?? ConstStyles.fontDescription(width),
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
