// import 'dart:math';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:nuskin_tr90_vn/app/constants/app_colors.dart';
// import 'package:nuskin_tr90_vn/app/constants/app_images.dart';
// import 'package:nuskin_tr90_vn/app/models/challenge_private_model.dart';
//
// class WeighCustomWidget extends StatefulWidget {
//   const WeighCustomWidget({Key? key, required this.challengePrivateModel})
//       : super(key: key);
//   final ChallengePrivateModel challengePrivateModel;
//
//   @override
//   State<WeighCustomWidget> createState() => _WeighCustomWidgetState();
// }
//
// class _WeighCustomWidgetState extends State<WeighCustomWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation; // Giá trị mới của begin
//   late double _endValue = 363.0; // Giá trị mới của end
//   bool _animationReversed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Khởi tạo controller animation với thời gian và curve
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//
//     // Định nghĩa animation từ 0 đến 180 độ
//     _rotationAnimation = Tween<double>(
//       begin: 176,
//       end: _endValue,
//     ).animate(_controller);
//     print("_handleValue");
//     print(_handleValue());
//     // Bắt đầu animation khi ứng dụng khởi động
//     _controller.forward();
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         if (_endValue == 363.0) {
//           _endValue = _handleValue(); // Thay đổi giá trị end
//         } else {
//           _endValue = 363.0; // Đặt lại giá trị end ban đầu
//         }
//         // Tạo animation mới với giá trị end mới và chạy nó
//         _rotationAnimation = Tween<double>(
//           begin: _endValue,
//           end: _rotationAnimation.value,
//         ).animate(_controller);
//
//         if (!_animationReversed) {
//           _controller.reverse();
//           _animationReversed = true;
//         } else {
//           _controller.forward();
//           _animationReversed = false;
//         }
//       }
//     });
//   }
//
//   double _handleValue() {
//     final double chartMin = 176.0;
//     final double chartMax = 363.0;
//     double valueMin = 0.0;
//     double valueMax = 0.0;
//     double valueCurrent = 0.0;
//
//     if (double.parse(widget.challengePrivateModel.valueGoal.toString()) > 0) {
//       valueMin =
//           double.parse(widget.challengePrivateModel.valueStart.toString());
//       valueMax =
//           double.parse(widget.challengePrivateModel.valueGoal.toString());
//       valueCurrent =
//           double.parse(widget.challengePrivateModel.valueCurrent.toString());
//       // double core = (chartMax - chartMin) / (valueMax - valueMin);
//     } else {
//       valueMin =
//           double.parse(widget.challengePrivateModel.valueStart.toString());
//       valueMax =
//           double.parse(widget.challengePrivateModel.valueGoal.toString());
//       valueCurrent =
//           double.parse(widget.challengePrivateModel.valueCurrent.toString());
//       // double core = (chartMax - chartMin) / (valueMax - valueMin);
//
//       //     -4
//       // 5  > -4                    0 >=  5
//       if (valueCurrent > valueMax && valueCurrent >= valueMin) {
//         valueCurrent = valueMin;
//       } else {
//         // valueCurrent = (valueMax) - (valueCurrent);
//       }
//     }
//
//     double result =
//         (chartMax - chartMin) * (valueCurrent / valueMax) + chartMin;
//     if (result >= chartMax) {
//       result = chartMax;
//     }
//     return result;
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final wight = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Container(
//       height: height * 0.21,
//       width: wight,
//       // margin: EdgeInsets.all(15),
//       child: LayoutBuilder(builder: (context, constraints) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 height: constraints.maxHeight * 0.18,
//                 width: constraints.maxHeight * 0.18,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.dark.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.2,
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(0),
//                     child: AnimatedBuilder(
//                         animation: _rotationAnimation,
//                         builder: (context, child) {
//                           return CustomPaint(
//                             painter:
//                             ClockBorder(value: _rotationAnimation.value),
//                             child: AspectRatio(
//                               aspectRatio: 2,
//                               child: SizedBox(),
//                             ),
//                           );
//                         }),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 30, right: 30, left: 30),
//                     // margin: EdgeInsets.all(15),
//                     child: AnimatedBuilder(
//                         animation: _rotationAnimation,
//                         builder: (context, child) {
//                           return CustomPaint(
//                             painter: BorderHalfCircle(
//                                 value: _rotationAnimation.value),
//                             child: AspectRatio(
//                               aspectRatio: 2,
//                               child: SizedBox(),
//                             ),
//                           );
//                         }),
//                   ),
//                   // Positioned(
//                   //   // bottom: -5,
//                   //   child: Container(
//                   //     height: constraints.maxHeight * 0.18,
//                   //     width: constraints.maxHeight * 0.18,
//                   //
//                   //     decoration: BoxDecoration(
//                   //         shape: BoxShape.circle, color: AppColors.dark12),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(2),
//                     child: AnimatedBuilder(
//                       animation: _rotationAnimation,
//                       builder: (context, child) {
//                         // print(_rotationAnimation.value);
//                         // print(_rotationAnimation.value * pi);
//                         return Transform.rotate(
//                           // angle: _rotationAnimation.value * pi / -90,
//                             angle: (_rotationAnimation.value + 90) * (pi / 180),
//                             origin: Offset(-2, -8),
//                             // Chuyển đổi từ radian sang độ
//                             alignment: Alignment.bottomCenter,
//                             child: Image.asset(
//                               AppImages.imgKim,
//                               fit: BoxFit.contain,
//                             ));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// class BorderHalfCircle extends CustomPainter {
//   final double value;
//
//   BorderHalfCircle({required this.value});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     double valueColor = value;
//     double heSo = 0.2;
//     if (valueColor >= 380) {
//       heSo = 8.0;
//     } else if (valueColor >= 360) {
//       heSo = 7.0;
//     } else if (valueColor >= 340) {
//       heSo = 6.0;
//     } else if (valueColor >= 320) {
//       heSo = 5.5;
//     } else if (valueColor >= 300) {
//       heSo = 4.5;
//     } else if (valueColor >= 280) {
//       heSo = 3.5;
//     } else if (valueColor >= 260) {
//       heSo = 3.0;
//     } else if (valueColor >= 240) {
//       heSo = 2.5;
//     } else if (valueColor >= 220) {
//       heSo = 2.0;
//     } else if (valueColor >= 200) {
//       heSo = 1.5;
//     } else if (valueColor >= 180) {
//       heSo = 1.0;
//     } else if (valueColor >= 100) {
//       heSo = 0.5;
//     } else {
//       heSo = 0.5; // Giá trị mặc định nếu không thỏa mãn bất kỳ điều kiện nào
//     }
//
//     final redCircle = Paint()
//       ..color = AppColors.dark
//       ..style = PaintingStyle.stroke
//       ..shader = LinearGradient(
//         colors: [AppColors.primary, AppColors.lightBlack],
//         begin: Alignment.centerLeft,
//         end: Alignment.center,
//         // stops: [0.8, 0.2],
//       ).createShader(
//           Rect.fromPoints(Offset(valueColor * heSo, 0), Offset(0, size.height)))
//       ..strokeWidth = 2;
//     final arcRect = Rect.fromCircle(
//         center: size.bottomCenter(Offset.zero), radius: size.shortestSide);
//     canvas.drawArc(arcRect, 0, -pi, false, redCircle);
//   }
//
//   @override
//   bool shouldRepaint(BorderHalfCircle oldDelegate) => false;
// }
//
// class ClockBorder extends CustomPainter {
//   final double value;
//
//   ClockBorder({required this.value});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = AppColors.primary
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.1;
//
//     final centerX = size.width / 2;
//     final centerY = size.height;
//     final radius = min(centerX, centerY);
//
//     final double angleStep = 5 * (pi / 180); // Góc bước giữa các thanh dọc
//     // Vẽ các đoạn thẳng tạo thành hình tròn
//     for (double angle = pi; angle < pi * 2; angle += angleStep) {
//       final x1 = centerX + radius * cos(angle);
//       final y1 = centerY + radius * sin(angle);
//
//       final x2 = centerX + (radius - 20) * cos(angle);
//       final y2 = centerY + (radius - 20) * sin(angle);
//
//       canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
//
//       double heSo = 4.0;
//       if (value > 340) {
//         heSo = 8;
//       } else if (value > 310) {
//         heSo = 7.5;
//       } else if (value > 270) {
//         heSo = 6.5;
//       } else if (value > 230) {
//         heSo = 3.5;
//       } else if (value >= 180) {
//         heSo = 2.5;
//       }
//
//       double heSoBorder = 0.4;
//       if (angle > 6) {
//         heSoBorder = 0.85;
//       } else if (angle > 5) {
//         heSoBorder = 0.75;
//       } else if (angle > 4.5) {
//         heSoBorder = 0.65;
//       } else if (angle > 4.2) {
//         heSoBorder = 0.55;
//       } else if (angle > 4) {
//         heSoBorder = 0.4;
//       } else if (angle > 3.5) {
//         heSoBorder = 0.42;
//       } else {
//         heSoBorder = 0.4;
//       }
//       if (value > angle * (180 / pi) + heSo) {
//         paint = Paint()
//           ..color = AppColors.primary
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = angle * heSoBorder;
//       } else {
//         paint = Paint()
//           ..color = AppColors.lightBlack
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = angle * heSoBorder;
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }