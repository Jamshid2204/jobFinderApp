import 'package:flutter/material.dart';
import 'package:jobfinderapp/controllers/bookmark_provider.dart';
import 'package:jobfinderapp/controllers/jobs_provider.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/models/response/bookmarks/book_res.dart';
import 'package:jobfinderapp/models/response/jobs/get_job.dart';
import 'package:jobfinderapp/services/helpers/jobs_helper.dart';
import 'package:jobfinderapp/views/common/BackBtn.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/custom_outline_btn.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage(
      {super.key,
      required this.title,
      required this.id,
      required String agentName});

  final String title;
  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late Future<GetJobRes> job;

  @override
  void initState() {
    super.initState();
    getjob();
  }

  getjob() {
    job = JobsHelper.getJob(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      // jobsNotifier.getJob(widget.id);
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            actions: [
              loginNotifier.loggedIn != false
                  ? Consumer<BookNotifier>(
                      builder: (context, bookNotifier, child) {
                      bookNotifier.getBookmark(widget.id);

                      return GestureDetector(
                        onTap: () {
                          // bookNotifier.getBookmark(widget.id);
                          print("add bookmark");
                          if (bookNotifier.bookmark == true) {
                            print("add bookmark");
                            bookNotifier
                                .deleteBookMark(bookNotifier.bookmarkId);
                          } else {
                            BookMarkReqRes model =
                                BookMarkReqRes(job: widget.id);
                            var newModel = bookMarkReqResToJson(model);
                            bookNotifier.addBookmark(newModel);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Icon(bookNotifier.bookmark == false
                              ? Fontisto.bookmark
                              : Fontisto.bookmark_alt),
                        ),
                      );
                    })
                  : const SizedBox.shrink()
            ],
            child: const BackBtn(),
          ),
        ),
        body: BuildStyleContainer(
            context,
            FutureBuilder<GetJobRes>(
                future: job,
                // future: jobsNotifier.job,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PageLoader();
                  } else if (snapshot.hasError) {
                    return Text("Error ty: + ${snapshot.error}");
                  } else {
                    final job = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Stack(
                        children: <Widget>[
                          ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              const HeightSpacer(size: 30),
                              Container(
                                width: width,
                                height: hieght * 0.27,
                                color: Color(kLightGrey.value),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/user.png'),
                                    ),
                                    const HeightSpacer(size: 10),
                                    ReusableText(
                                      text: job!.title,
                                      style: appStyle(22, Color(kDark.value),
                                          FontWeight.w600),
                                    ),
                                    const HeightSpacer(size: 5),
                                    ReusableText(
                                      text: job.location,
                                      style: appStyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.normal),
                                    ),
                                    const HeightSpacer(size: 15),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // CustomOutlineBtn(
                                          //   text: job.contract,
                                          //   color1: Color(kOrange.value),
                                          //   color2: Color(kLight.value),
                                          //   width: width * 0.2,
                                          //   height: hieght * 0.04,
                                          //   color: const Color.fromARGB(
                                          //       255, 16, 155, 23),
                                          // ),
                                          Row(
                                            children: <Widget>[
                                              ReusableText(
                                                text: job.salary,
                                                style: appStyle(
                                                  22,
                                                  Color(kDark.value),
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.3,
                                                child: ReusableText(
                                                  text: job.period,
                                                  style: appStyle(
                                                    22,
                                                    Color(kDark.value),
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                text: 'Job Description',
                                style: appStyle(
                                    22, Color(kDark.value), FontWeight.w600),
                              ),
                              const HeightSpacer(size: 10),
                              Text(
                                job.description,
                                textAlign: TextAlign.justify,
                                maxLines: 8,
                                style: appStyle(
                                  16,
                                  Color(kDarkGrey.value),
                                  FontWeight.normal,
                                ),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                text: "Job requirements",
                                style: appStyle(
                                    22, Color(kDark.value), FontWeight.w600),
                              ),
                              const HeightSpacer(size: 10),
                              SizedBox(
                                height: hieght * 0.6,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: job.requirements.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final req = job.requirements[index];
                                    String bullet = "\u2022";
                                    return Text(
                                      "$bullet $req\n",
                                      maxLines: 4,
                                      style: appStyle(
                                        16,
                                        Color(kDarkGrey.value),
                                        FontWeight.normal,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const HeightSpacer(size: 80),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.0.w),
                              child: CustomOutlineBtn(
                                text: !loginNotifier.loggedIn
                                    ? "Please Login"
                                    : "Apply Now",
                                width: width,
                                hieght: hieght * 0.06,
                                color1: Color(kLight.value),
                                color2: Color(kOrange.value),
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                })),
      );
    });
  }
}








      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
      //   child: Stack(
      //     children: <Widget>[
      //       ListView(
      //         padding: EdgeInsets.zero,
      //         children: <Widget>[
      //           const HeightSpacer(size: 30),
      //           Container(
      //             width: width,
      //             height: hieght * 0.27,
      //             color: Color(kLightGrey.value),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 const CircleAvatar(
      //                   backgroundImage: AssetImage('assets/images/user.png'),
      //                 ),
      //                 const HeightSpacer(size: 10),
      //                 ReusableText(
      //                   text: 'Senior Flutter Developer',
      //                   style:
      //                       appStyle(22, Color(kDark.value), FontWeight.w600),
      //                 ),
      //                 const HeightSpacer(size: 5),
      //                 ReusableText(
      //                   text: 'Washington DC',
      //                   style: appStyle(
      //                       16, Color(kDarkGrey.value), FontWeight.normal),
      //                 ),
      //                 const HeightSpacer(size: 15),
      //                 Padding(
      //                   padding: EdgeInsets.symmetric(horizontal: 50.w),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       CustomOutlineBtn(
      //                         text: "Full-time",
      //                         color1: Color(kOrange.value),
      //                         color2: Color(kLight.value),
      //                         width: width * 0.26,
      //                         height: hieght * 0.04, color: const Color.fromARGB(255, 16, 155, 23),
      //                       ),
      //                       Row(
      //                         children: <Widget>[
      //                           ReusableText(
      //                             text: '10k',
      //                             style: appStyle(
      //                               22,
      //                               Color(kDark.value),
      //                               FontWeight.w600,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             width: width * 0.2,
      //                             child: ReusableText(
      //                               text: '/monthly',
      //                               style: appStyle(
      //                                 22,
      //                                 Color(kDark.value),
      //                                 FontWeight.w600,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           const HeightSpacer(size: 20),
      //           ReusableText(
      //             text: 'Job Description',
      //             style: appStyle(22, Color(kDark.value), FontWeight.w600),
      //           ),
      //           const HeightSpacer(size: 10),
      //           Text(
      //             desc,
      //             textAlign: TextAlign.justify,
      //             maxLines: 8,
      //             style: appStyle(
      //               16,
      //               Color(kDarkGrey.value),
      //               FontWeight.normal,
      //             ),
      //           ),
      //           const HeightSpacer(size: 20),
      //           ReusableText(
      //             text: 'Requirements',
      //             style: appStyle(22, Color(kDark.value), FontWeight.w600),
      //           ),
      //           const HeightSpacer(size: 10),
      //           SizedBox(
      //             height: hieght * 0.6,
      //             child: ListView.builder(
      //               padding: EdgeInsets.zero,
      //               itemCount: requirements.length,
      //               physics: const NeverScrollableScrollPhysics(),
      //               itemBuilder: (context, index) {
      //                 final req = requirements[index];
      //                 String bullet = "\u2022";
      //                 return Text(
      //                   "$bullet $req\n",
      //                   maxLines: 4,
      //                   style: appStyle(
      //                     16,
      //                     Color(kDarkGrey.value),
      //                     FontWeight.normal,
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //           const HeightSpacer(size: 80),
      //         ],
      //       ),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Padding(
      //           padding: EdgeInsets.only(bottom: 20.h),
      //           child: CustomOutlineBtn(
      //             text: "Apply Now",
      //             width: width,
      //             height: hieght * 0.06,
      //             color1: Color(kLight.value),
      //             color2: Color(kOrange.value), color: const Color.fromARGB(255, 16, 155, 23),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
