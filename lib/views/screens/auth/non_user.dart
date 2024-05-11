import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/custom_outline_btn.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/screens/auth/login.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.webp?b=1&s=170667a&w=0&k=20&c=KZM6TIhdaJAy28BA9sg0Sn-ZRd160F6HytdAKykza-s=';
    return BuildStyleContainer(
      context,
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(99.w)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: 70.w,
              height: 70.h,
            ),
          ),
          const HeightSpacer(size: 20),
          ReusableText(
            text: "To access content please login",
            style: appStyle(12, Color(kDarkGrey.value), FontWeight.normal),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
            child: CustomOutlineBtn(
              onTap: () {
                Get.to(() => const LoginPage());
              },
              width: width,
              hieght: 40,
              text: "Proceed to login",
              color: Color(kOrange.value),
              color1: Color(kOrange.value),
            ),
          ),
        ],
      ),
    );
  }
}
