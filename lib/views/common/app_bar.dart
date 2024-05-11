import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.text, required this.child, this.actions, this.color});

  final String? text;
  final Widget child;
  final Color? color;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: color ?? Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: ReusableText(
          text: text ?? "",
          style: appStyle(
              16,
              color != null ? Color(kLight.value) : Color(kDark.value),
              FontWeight.w600)),
    );
  }
}
