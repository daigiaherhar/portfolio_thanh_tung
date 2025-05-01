import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_thanh_tung/constants/const_color.dart';
import 'package:portfolio_thanh_tung/constants/const_style.dart';

class ContainerSmokeWidget extends StatelessWidget {
  const ContainerSmokeWidget({super.key,this.onTap});
  final onTap;
  // final String Text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ConstStyles.padding_vertical_25,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                padding: ConstStyles.padding_25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .shimmer(duration: 5.seconds)
                  .blurXY(
                    begin: 0,
                    end: 30,
                    duration: 5.seconds,
                  )
                  .fadeIn(duration: 3.seconds),
            ),
            Container(
              padding: ConstStyles.padding_25,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ConstColors.orange,
                ),
                // màu ban đầu
                borderRadius: BorderRadius.circular(5),
              ),
              // child: Text("435345"),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .custom(
                  duration: 2.seconds,
                  builder: (context, value, child) {
                    final color = Color.lerp(
                      ConstColors.purple,
                      ConstColors.purple.withValues(alpha: 0.8),
                      value,
                    )!;
                    return Container(
                      padding: ConstStyles.padding_5,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: color),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent),
                      child: Center(
                        child: Text(
                          "Download My CV",
                          style: TextStyle(color: ConstColors.white),
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
