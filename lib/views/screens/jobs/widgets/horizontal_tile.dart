import 'package:flutter/material.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          color: Color(kLightGrey.value),
          width: width * 0.7,
          height: hieght * 0.27,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Facebook.png'),
                  ),
                  const WidthSpacer(width: 12),
                  ReusableText(
                    text: 'FaceBook',
                    style: appStyle(26, Color(kDark.value), FontWeight.w600),
                  ),
                ],
              ),
              const HeightSpacer(size: 15),
              ReusableText(
                text: 'Senior Flutter Developer',
                style: appStyle(20, Color(kDark.value), FontWeight.w600),
              ),
              ReusableText(
                text: 'Washington DC',
                style: appStyle(16, Color(kDarkGrey.value), FontWeight.w600),
              ),
              const HeightSpacer(size: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      ReusableText(
                        text: '15k',
                        style:
                            appStyle(23, Color(kDark.value), FontWeight.w600),
                      ),
                      ReusableText(
                        text: '/monthly',
                        style: appStyle(
                            23, Color(kDarkGrey.value), FontWeight.w600),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: const Icon(Ionicons.chevron_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
