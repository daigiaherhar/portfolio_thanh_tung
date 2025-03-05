import 'package:flutter/material.dart';

import '../constants/constants.dart';

class OnHoverButton extends StatefulWidget {
  const OnHoverButton(
      {super.key,
        required this.child,
        this.onTap,
        this.colorHover,
        this.margin,
        this.padding});

  final Widget child;
  final onTap;
  final Color? colorHover;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  State<OnHoverButton> createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHover = false;

  onEntered(bool isHover) {
    setState(() {
      this.isHover = isHover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
            margin: widget.margin ?? EdgeInsets.all(10),
            padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),

            // height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isHover
                  ? widget.colorHover ?? ConstColors.grey.withValues(alpha: 0.2)
                  : ConstColors.transparent,
              // backgroundBlendMode: BlendMode.difference
            ),
            child: widget.child),
      ),
    );
  }
}