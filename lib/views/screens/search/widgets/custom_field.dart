import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key, this.onTap, required this.controller, this.onChanged});

  final TextEditingController controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      padding: EdgeInsets.only(bottom: 0.w),
      color: const Color.fromARGB(250, 240, 240, 240),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const WidthSpacer(width: 5),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                // child: Padding(
                child: Icon(
                  Ionicons.chevron_back_circle,
                  size: 35.h,
                  color: Color(kOrange.value),
                ),
                // ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.h, left: 0),
                width: width * 0.7,
                child: TextFormField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      hintText: "search a job",
                      hintStyle:
                          appStyle(14, Color(kDarkGrey.value), FontWeight.w500),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Color(kDarkGrey.value), width: 0.5)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 0.5)),
                      border: InputBorder.none),
                  controller: controller,
                  cursorHeight: 25,
                  style: appStyle(14, Color(kDark.value), FontWeight.w500),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            // child: Padding(
            // padding: const EdgeInsets.all(8.0),
            child: Icon(
              Ionicons.search_circle_outline,
              size: 35.h,
              color: Color(kOrange.value),
            ),
            // ),
          ),
        ],
      ),
    );
  }
}
