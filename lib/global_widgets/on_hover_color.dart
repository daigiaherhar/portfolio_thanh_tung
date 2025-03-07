import 'package:flutter/material.dart';

class OnHoverColor extends StatefulWidget {
  const OnHoverColor({
    super.key,
    required this.child,
    required this.color,
    required this.colorHover,
    this.padding,
    this.margin,
    this.radius,
    this.onTap,
    this.enterHover,
    this.exitHover,
  });

  final Widget child;
  final Color color;
  final Color colorHover;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final onTap;
  final enterHover;
  final exitHover;

  // final double? op;

  @override
  State<OnHoverColor> createState() => _OnHoverColorState();
}

class _OnHoverColorState extends State<OnHoverColor> {
  bool isHover = false;

  onEntered(bool isHover) {
    setState(() {
      this.isHover = isHover;

      if (isHover) {
        // if (!this.isHover)
        //   if (widget.enterHover != null)
        //     WidgetsBinding.instance.addPostFrameCallback(
        //       (timeStamp) => widget.enterHover(),
        //     );
      } else {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => widget.exitHover(),);
        print("isHover233");
        print(isHover);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      // onHover: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: widget.padding ?? EdgeInsets.all(5),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: isHover ? widget.colorHover : widget.color,
            borderRadius: BorderRadius.circular(widget.radius ?? 10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(1, 3),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
