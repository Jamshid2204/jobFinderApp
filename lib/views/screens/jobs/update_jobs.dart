import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/controllers/zoom_provider.dart';
import 'package:jobfinderapp/models/request/jobs/create_job.dart';
import 'package:jobfinderapp/services/helpers/jobs_helper.dart';
import 'package:jobfinderapp/views/common/BackBtn.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/custom_outline_btn.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/common/textfield.dart';
import 'package:jobfinderapp/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateJobs extends StatefulWidget {
  const UpdateJobs({super.key});

  @override
  State<UpdateJobs> createState() => _UpdateJobs();
}

class _UpdateJobs extends State<UpdateJobs> {
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController rq1 = TextEditingController();
  TextEditingController rq2 = TextEditingController();
  TextEditingController rq3 = TextEditingController();
  TextEditingController rq4 = TextEditingController();
  TextEditingController rq5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppBar(
              color: Color(kNewBlue.value),
              text: "Upload Job",
              child: const BackBtn())),
      body: Stack(
        children: [
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(kLight.value),
                ),
                child: BuildStyleContainer(
                    context,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 20),
                      child: ListView(
                        children: [
                          const HeightSpacer(size: 10),
                          // title
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill tthe field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Job Title"),
                                hintText: "Job title",
                                controller: title),
                          ),
                          // location
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Location"),
                                hintText: "Location",
                                controller: location),
                          ),
                          // company
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Company"),
                                hintText: "Company",
                                controller: company),
                          ),
                          // description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 120,
                              maxLines: 3,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Description"),
                                hintText: "Description",
                                controller: description),
                          ),
                          // category
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Category"),
                                hintText: "Category",
                                controller: category),
                          ),
                          // salary
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("salary"),
                                hintText: "salary",
                                controller: salary),
                          ),
                          // contract
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Contract"),
                                hintText: "Contract",
                                controller: contract),
                          ),
                          // period
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Salary Period"),
                                hintText: "Monthly | Annual | Weekly",
                                controller: period),
                          ),
                          ReusableText(text: "Requirements", style: appStyle(15, Colors.black, FontWeight.w600)),
                          const HeightSpacer(size: 10),
                          // req1
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 50,
                              maxLines: 2,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requirement 1"),
                                hintText: "Requirements",
                                controller: rq1),
                          ),
                          // req2
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 50,
                              maxLines: 2,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requirement 2"),
                                hintText: "Requirements",
                                controller: rq2),
                          ),
                          // req3
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 50,
                              maxLines: 2,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requirement 3"),
                                hintText: "Requirements",
                                controller: rq3),
                          ),
                          // req4
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 50,
                              maxLines: 2,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requirement 4"),
                                hintText: "Requirements",
                                controller: rq4),
                          ),
                          // req5
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildtextfield(
                              height: 50,
                              maxLines: 2,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please fill the field");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requirement 5"),
                                hintText: "Requirements",
                                controller: rq5),
                          ),

                          CustomOutlineBtn(
                                            onTap: () async{
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              String agentName = prefs.getString("username")?? "";
                                              var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);
                                              CreateJobsRequest rawModel = CreateJobsRequest(
                                              title: title.text, 
                                              location: location.text, 
                                              company: company.text, 
                                              agentName: agentName, 
                                              description: description.text, 
                                              category: category.text, 
                                              salary: salary.text, 
                                              contract: contract.text, 
                                              hiring: true, 
                                              period: period.text, 
                                              imageUrl: 'https://cdn-icons-png.flaticon.com/128/3985/3985018.png', 
                                              agentId: userUid, 
                                              requirements: [
                                                rq1.text,
                                                rq2.text,
                                                rq3.text,
                                                rq4.text,
                                                rq5.text,
                                              ]);
                                              var model = createJobsRequestToJson(rawModel);
                                              JobsHelper.createJob(model);
                                              zoomNotifier.currentIndex = 0;
                                              Get.to(() => const MainScreen());
                                            },
                                            width: 50.w,
                                            hieght: 40.h,
                                            text: "Submit",
                                            color: Color(kOrange.value),
                                            color1: Color(kOrange.value))

                        ],
                      ),
                    ),
                    
                    ),
              
              ))
        ],
      ),
    );
  }
}
