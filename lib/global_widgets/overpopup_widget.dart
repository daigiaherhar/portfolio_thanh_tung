import 'package:flutter/material.dart';
import 'package:portfolio_thanh_tung/constants/const_color.dart';

class OverPopupPage extends StatefulWidget {
  final Offset showOffset;
  final Size buttonSize;
  final widget;

  OverPopupPage({
    required this.showOffset,
    required this.buttonSize,
    required this.widget,
  });

  @override
  _OverPopupPageState createState() => _OverPopupPageState();
}

class _OverPopupPageState extends State<OverPopupPage> {
  final List<Color> listColor = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];

  var opacity = 0.0;
  var heightPop = 0.0;
  var widthPop = 0.0;

  void _show(bool isVisible) {
    setState(() {
      opacity = isVisible ? 1.0 : 0.0;
      heightPop = widget.buttonSize.height;
      widthPop = widget.buttonSize.width;
    });

    print("widget.showOffset.dx");
    print(widget.showOffset.dx);
    print(widget.buttonSize.width);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _show(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _show(false);
                Navigator.of(context).pop();
                print("234");
              },
              // child: SizedBox(height: height,),
            ),
          ),
          Positioned(
            top: widget.showOffset.dy + widget.buttonSize.height - 5,
            right: 0,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: ConstColors.black_1,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                // height: heightPop,
                // width: widget.buttonSize.width,
                duration: Duration(milliseconds: 300),
                child: widget.widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
