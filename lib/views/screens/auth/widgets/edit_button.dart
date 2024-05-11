import 'package:flutter/material.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/views/common/exports.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, this.onTap});

  final void Function()? onTap;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color(kOrange.value),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(9), bottomLeft: Radius.circular(9)),
        ),
        child: ReusableText(
          text: "Edit",
          style: appStyle(12, Color(kLight.value), FontWeight.w500),),
      ),
    );
  }
}
