import 'package:flutter/material.dart';
import 'package:portfolio_thanh_tung/constants/const_color.dart';

class Alert {
  static Future<dynamic> showLoading(context, {required String message}) {
    return showGeneralDialog(
      context: context,
      // barrierColor: Colors.white,
      // barrierDismissible: true,
      // barrierLabel: "!2312",
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(scale: anim, child: child);
      },
      // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Text(
            "Lỗi",
            style: TextStyle(
              color: ConstColors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          backgroundColor: ConstColors.white,
          content: Text(
            message,
            style: TextStyle(
              color: ConstColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            InkWell(
              onTap: () => {Navigator.of(context, rootNavigator: true).pop()},
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: ShaderMask(
                  child: Text(
                    "Đóng",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  shaderCallback: (rect) {
                    return LinearGradient(
                      colors: [
                        ConstColors.orange,
                        ConstColors.red,

                        ConstColors.green_1,
                      ],
                    ).createShader(rect);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
