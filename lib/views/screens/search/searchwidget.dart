import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/services/helpers/jobs_helper.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/loader.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/jobs/job_page.dart';
import 'package:jobfinderapp/views/screens/jobs/jobs_horizontal_tile.dart';
import 'package:jobfinderapp/views/screens/search/widgets/custom_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          child: CustomField(
            // hintText: "Search a Job",
            controller: controller,
            // suffixIcon: GestureDetector(
            onChanged: (String text) {
              setState(() {});
            },
            // child: const Icon(AntDesign.search1),
            // ),
          ),
        ),
        // elevation: 0,
      ),
      body: controller.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
              child: FutureBuilder<List<JobsResponse>>(
                  future: JobsHelper.searchJobs(controller.text),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    text: job.id,
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
                                                          Color(
                                                              kDarkGrey.value),
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
                                    ],
                                  ),
                                )),
                          );
                          ;
                        },
                      );
                    }
                  }))
          : const NoSearchResults(text: "Start Searching..."),
    );
  }
}
