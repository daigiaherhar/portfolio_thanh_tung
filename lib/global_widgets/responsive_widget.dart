import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  ResponsiveWidget({super.key, required this.mobile, required this.web});

  final Widget mobile;
  final Widget web;
  late ValueNotifier<bool> changeWidget = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          changeWidget.value = true;
        } else {
          changeWidget.value = false;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            // 👉 Kiểm tra key để chọn hướng trượt
            final isFirst = child.key == const ValueKey('mobile');
            final offsetAnimation = Tween<Offset>(
              begin: isFirst ? const Offset(1, 0) : const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: changeWidget.value
              ? SizedBox(key: const ValueKey('mobile'), child: mobile)
              : SizedBox(key: const ValueKey('web'), child: web),
        );
      },
    );
  }
}
