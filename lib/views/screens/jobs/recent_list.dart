import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/jobs_provider.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/jobs/job_page.dart';
import 'package:provider/provider.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getRecent();
      return SizedBox(
          height: hieght * 0.215,
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.recentJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: + ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const Text("No jobs avialable!");
                } else {
                  final jobs = snapshot.data;

                  return ListView.builder(
                    itemCount: jobs!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var job = jobs[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(JobPage(title: job.title, id: job.id, agentName: job.agentName,));
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            // onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              height: hieght * 0.10,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(kLightGrey.value),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(9))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Color(kLightGrey.value),
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(job.imageUrl),
                                          ),
                                          const WidthSpacer(width: 25),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: job.location,
                                                style: appStyle(
                                                    15,
                                                    Color(kDark.value),
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: width * 0.5,
                                                child: ReusableText(
                                                  text: job.title,
                                                  style: appStyle(
                                                      12,
                                                      Color(kDarkGrey.value),
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              ReusableText(
                                                text:
                                                    "${job.salary} per ${job.period}",
                                                style: appStyle(
                                                    15,
                                                    Color(kDark.value),
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                Color(kLight.value),
                                            child: const Icon(
                                                Ionicons.chevron_forward),
                                          )
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
                      );
                    },
                  );
                }
              }));
    });
  }
}
