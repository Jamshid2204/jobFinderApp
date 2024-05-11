import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/jobs/job_page.dart';

class UploadedTile extends StatelessWidget {
  const UploadedTile({super.key, required this.job});

  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Get.to(JobPage(title: job.title, id: job.id, agentName: job.agentName,));
        },
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            // onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: hieght * 0.10,
              width: width,
              decoration: BoxDecoration(
                  color: Color(kLightGrey.value),
                  borderRadius: const BorderRadius.all(Radius.circular(9))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(kLightGrey.value),
                            radius: 25,
                            backgroundImage: NetworkImage(job.imageUrl),
                          ),
                          const WidthSpacer(width: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: job.location,
                                style: appStyle(
                                    15, Color(kDark.value), FontWeight.w600),
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: ReusableText(
                                  text: job.title,
                                  style: appStyle(12, Color(kDarkGrey.value),
                                      FontWeight.w600),
                                ),
                              ),
                              ReusableText(
                                text: "${job.salary}  ${job.period}",
                                style: appStyle(
                                    15, Color(kDark.value), FontWeight.w600),
                              ),
                            ],
                          ),
                          // CircleAvatar(
                          //   radius: 18,
                          //   backgroundColor: Color(kLight.value),
                          //   child: const Icon(Ionicons.chevron_forward),
                          // )
                        ],
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 12.w),
                  //   child: Row(
                  //     children: [
                  //       ReusableText(
                  //           text: job.salary,
                  //           style: appStyle(
                  //               15,
                  //               Color(kDark.value),
                  //               FontWeight.w600)),
                  //       ReusableText(
                  //           text: "/${job.period}",
                  //           style: appStyle(
                  //               15,
                  //               Color(kDarkGrey.value),
                  //               FontWeight.w600))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
