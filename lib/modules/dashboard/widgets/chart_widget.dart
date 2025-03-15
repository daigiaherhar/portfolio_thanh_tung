import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_thanh_tung/constants/const_images.dart';

import '../../../constants/constants.dart';
import '../../../global_widgets/animated_flip_counter.dart';
import '../models/index.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
    required this.chartSkillModel,
    required this.scrollController,
  }) : super(key: key);
  final ChartSkillModel chartSkillModel;
  final ScrollController scrollController;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation; // Giá trị mới của begin
  late double _endValue = 363.0; // Giá trị mới của end
  bool _animationReversed = false;
  bool isAnimateScroll = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller animation với thời gian và curve
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      animationBehavior: AnimationBehavior.normal,
    );

    // Định nghĩa animation từ 0 đến 180 độ
    _rotationAnimation = Tween<double>(
      begin: 176,
      end: _endValue,
    ).animate(_controller);

    print("_handleValue");
    print(_handleValue());
    // Bắt đầu animation khi ứng dụng khởi động
    // _controller.forward();
    _controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        if (_endValue == 363.0) {
          _endValue = _handleValue(); // Thay đổi giá trị end
        } else {
          _endValue = 363.0; // Đặt lại giá trị end ban đầu
        }
        // Tạo animation mới với giá trị end mới và chạy nó
        _rotationAnimation = Tween<double>(
          begin: _endValue,
          end: _rotationAnimation.value,
        ).animate(_controller);
      }
      if (_controller.status.isCompleted) {
        _controller.reverse();
      }
    });
    scrollAnimate();
  }

  double _handleValue() {
    final double chartMin = 176.0;
    final double chartMax = 363.0;
    double valueMin = 0.0;
    double valueMax = 0.0;
    double valueCurrent = 0.0;

    if (double.parse(widget.chartSkillModel.valueGoal.toString()) > 0) {
      valueMin = double.parse(widget.chartSkillModel.valueStart.toString());
      valueMax = double.parse(widget.chartSkillModel.valueGoal.toString());
      valueCurrent = double.parse(
        widget.chartSkillModel.valueCurrent.toString(),
      );
      // double core = (chartMax - chartMin) / (valueMax - valueMin);
    } else {
      valueMin = double.parse(widget.chartSkillModel.valueStart.toString());
      valueMax = double.parse(widget.chartSkillModel.valueGoal.toString());
      valueCurrent = double.parse(
        widget.chartSkillModel.valueCurrent.toString(),
      );
      // double core = (chartMax - chartMin) / (valueMax - valueMin);

      //     -4
      // 5  > -4                    0 >=  5
      if (valueCurrent > valueMax && valueCurrent >= valueMin) {
        valueCurrent = valueMin;
      } else {
        // valueCurrent = (valueMax) - (valueCurrent);
      }
    }

    double result =
        (chartMax - chartMin) * (valueCurrent / valueMax) + chartMin;
    if (result >= chartMax) {
      result = chartMax;
    }
    return result;
  }

  scrollAnimate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.addListener(() => _scrollListener());
    });
  }

  _scrollListener() {
    _handeAnimate(
      dWidget: widget.scrollController.position.maxScrollExtent * .075,
      dScroll: widget.scrollController.offset,
    );
  }

  _handeAnimate({double dWidget = 0, double dScroll = 0}) {
    setState(() {
      if ((dScroll >= dWidget)) {
      } else {
        if (!isAnimateScroll) _controller.forward();

        isAnimateScroll = true;
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scrollAnimate(); //web thay doi
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      // key: widget.chartSkillModel.key,
      children: [
        Container(
          height: height * 0.21,
          // width: width,
          // margin: EdgeInsets.all(15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Positioned(
                  //   bottom: 0,
                  //   child: Container(
                  //     height: constraints.maxHeight * 0.18,
                  //     width: constraints.maxHeight * 0.18,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.2,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: ClockBorder(
                                  value: _rotationAnimation.value,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: SizedBox(),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                            right: 30,
                            left: 30,
                          ),
                          // margin: EdgeInsets.all(15),
                          child: AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: BorderHalfCircle(
                                  value: _rotationAnimation.value,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: SizedBox(),
                                ),
                              );
                            },
                          ),
                        ),
                        // Positioned(
                        //   // bottom: -5,
                        //   child: Container(
                        //     height: constraints.maxHeight * 0.18,
                        //     width: constraints.maxHeight * 0.18,
                        //
                        //     decoration: BoxDecoration(
                        //         shape: BoxShape.circle, color: AppColors.dark12),
                        //   ),
                        // ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              // print(_rotationAnimation.value);
                              // print(_rotationAnimation.value * pi);
                              return Transform.rotate(
                                // angle: _rotationAnimation.value * pi / -90,
                                angle:
                                    (_rotationAnimation.value + 90) *
                                    (pi / 180),
                                origin: Offset(-2, -8),
                                // Chuyển đổi từ radian sang độ
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  // padding: EdgeInsets.all(15),
                                  width: 5,
                                  height: width * .2,
                                  decoration: BoxDecoration(
                                    color: ConstColors.grey_2,

                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(100),
                                      bottom: Radius.circular(100),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Text(
          widget.chartSkillModel.valueCurrent.toString(),
          style: TextStyle(
            color: ConstColors.white,
            fontSize: ConstStyles.fontTitle(width),
          ),
        ),
        Text(
          widget.chartSkillModel.name.toString(),
          style: TextStyle(
            color: ConstColors.white,
            fontSize: ConstStyles.fontTitle(width),
          ),
        ),
      ],
    );
  }
}

class BorderHalfCircle extends CustomPainter {
  final double value;

  BorderHalfCircle({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    double valueColor = value;
    double heSo = 0.2;
    if (valueColor >= 380) {
      heSo = 8.0;
    } else if (valueColor >= 360) {
      heSo = 7.0;
    } else if (valueColor >= 340) {
      heSo = 6.0;
    } else if (valueColor >= 320) {
      heSo = 5.5;
    } else if (valueColor >= 300) {
      heSo = 4.5;
    } else if (valueColor >= 280) {
      heSo = 3.5;
    } else if (valueColor >= 260) {
      heSo = 3.0;
    } else if (valueColor >= 240) {
      heSo = 2.5;
    } else if (valueColor >= 220) {
      heSo = 2.0;
    } else if (valueColor >= 200) {
      heSo = 1.5;
    } else if (valueColor >= 180) {
      heSo = 1.0;
    } else if (valueColor >= 100) {
      heSo = 0.5;
    } else {
      heSo = 0.5; // Giá trị mặc định nếu không thỏa mãn bất kỳ điều kiện nào
    }

    final redCircle =
        Paint()
          ..color = ConstColors.grey_2
          ..style = PaintingStyle.stroke
          ..shader = LinearGradient(
            colors: [ConstColors.orange, ConstColors.grey_2],
            begin: Alignment.centerLeft,
            end: Alignment.center,
            // stops: [0.8, 0.2],
          ).createShader(
            Rect.fromPoints(
              Offset(valueColor * heSo, 0),
              Offset(0, size.height),
            ),
          )
          ..strokeWidth = 2;
    final arcRect = Rect.fromCircle(
      center: size.bottomCenter(Offset.zero),
      radius: size.shortestSide,
    );
    canvas.drawArc(arcRect, 0, -pi, false, redCircle);
  }

  @override
  bool shouldRepaint(BorderHalfCircle oldDelegate) => false;
}

class ClockBorder extends CustomPainter {
  final double value;

  ClockBorder({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = ConstColors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1;

    final centerX = size.width / 2;
    final centerY = size.height;
    final radius = min(centerX, centerY);

    final double angleStep = 5 * (pi / 180); // Góc bước giữa các thanh dọc
    // Vẽ các đoạn thẳng tạo thành hình tròn
    for (double angle = pi; angle < pi * 2; angle += angleStep) {
      final x1 = centerX + radius * cos(angle);
      final y1 = centerY + radius * sin(angle);

      final x2 = centerX + (radius - 20) * cos(angle);
      final y2 = centerY + (radius - 20) * sin(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

      double heSo = 4.0;
      if (value > 340) {
        heSo = 8;
      } else if (value > 310) {
        heSo = 7.5;
      } else if (value > 270) {
        heSo = 6.5;
      } else if (value > 230) {
        heSo = 3.5;
      } else if (value >= 180) {
        heSo = 2.5;
      }

      double heSoBorder = 0.4;
      if (angle > 6) {
        heSoBorder = 0.85;
      } else if (angle > 5) {
        heSoBorder = 0.75;
      } else if (angle > 4.5) {
        heSoBorder = 0.65;
      } else if (angle > 4.2) {
        heSoBorder = 0.55;
      } else if (angle > 4) {
        heSoBorder = 0.4;
      } else if (angle > 3.5) {
        heSoBorder = 0.42;
      } else {
        heSoBorder = 0.4;
      }
      if (value > angle * (180 / pi) + heSo) {
        paint =
            Paint()
              ..color = ConstColors.orange
              ..style = PaintingStyle.stroke
              ..strokeWidth = angle * heSoBorder;
      } else {
        paint =
            Paint()
              ..color = ConstColors.grey_2
              ..style = PaintingStyle.stroke
              ..strokeWidth = angle * heSoBorder;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
