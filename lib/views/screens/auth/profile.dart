import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/controllers/zoom_provider.dart';
import 'package:jobfinderapp/models/response/auth/profile_model.dart';
import 'package:jobfinderapp/services/helpers/auth_helper.dart';
import 'package:jobfinderapp/views/common/BackBtn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/views/common/custom_outline_btn.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:jobfinderapp/views/screens/auth/widgets/edit_button.dart';
import 'package:jobfinderapp/views/screens/auth/widgets/skills.dart';
import 'package:jobfinderapp/views/screens/jobs/add_jobs.dart';
import 'package:jobfinderapp/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.drawer});
  final bool drawer;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileRes> userProfile;

  String username = '';
  // ProfileRes? profile;
  String profilePic = '';
  String image = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';

  @override
  void initState() {
    super.initState();
    getName();
    getProfile();
  }

  getProfile() {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    if (widget.drawer == false && loginNotifier.loggedIn == true) {
      userProfile = AuthHelper.getProfile();
    } else if (widget.drawer == true && loginNotifier.loggedIn == true) {
      userProfile = AuthHelper.getProfile();
    } else {}
  }

  getName() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.drawer == false && loginNotifier.loggedIn == true) {
      username = prefs.getString('username') ?? '';
      profilePic = prefs.getString('profile') ?? '';
    } else if (widget.drawer == true && loginNotifier.loggedIn == true) {
      username = prefs.getString('username') ?? '';
      profilePic = prefs.getString('profile') ?? '';
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor: loginNotifier.loggedIn
            ? Color(kNewBlue.value)
            : Color(kLight.value),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            color: loginNotifier.loggedIn
                ? Color(kNewBlue.value)
                : Color(kLight.value),
            text: loginNotifier.loggedIn ? username.toUpperCase() : '',
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: widget.drawer == false
                  ? const BackBtn(color: Colors.white,)
                  : DrawerWidget(
                      color: Color(kLight.value),
                    ),
              // child: const DrawerWidget(color: Color.fromARGB(255, 16, 155, 23),),
            ),
          ),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Stack(
                children: [
                  Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color(kLight.value),
                        ),
                        child: FutureBuilder(
                            future: userProfile,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const PageLoader();
                              } else if (snapshot.hasError) {
                                return Text("Error type: + ${snapshot.error}");
                              } else {
                                var profile = snapshot.data;
                                return BuildStyleContainer(
                                    context,
                                    ListView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      children: [
                                        const HeightSpacer(size: 10),
                                        Container(
                                          width: width,
                                          height: hieght * 0.15,
                                          decoration: BoxDecoration(
                                              color: Color(kLightGrey.value),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  CircularAvatar(
                                                    image: image,
                                                    w: 50,
                                                    h: 50,
                                                  ),
                                                  const WidthSpacer(width: 20),
                                                  SizedBox(
                                                    height: 70,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ReusableText(
                                                            text: profile!.id,
                                                            style: appStyle(
                                                                15,
                                                                Color(kDark
                                                                    .value),
                                                                FontWeight
                                                                    .w400)),
                                                        ReusableText(
                                                            text: profile!
                                                                .username,
                                                            style: appStyle(
                                                                15,
                                                                Color(kDark
                                                                    .value),
                                                                FontWeight
                                                                    .w400)),
                                                        ReusableText(
                                                            text:
                                                                profile!.email,
                                                            style: appStyle(
                                                                15,
                                                                Color(kDark
                                                                    .value),
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.0.w),
                                                      child: Icon(
                                                        Feather.edit,
                                                        color:
                                                            Color(kDark.value),
                                                      )))
                                            ],
                                          ),
                                        ),
                                        const HeightSpacer(size: 20),
                                        ReusableText(
                                            text: "User Profile",
                                            style: appStyle(
                                                15,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        Stack(
                                          children: [
                                            Container(
                                              width: width,
                                              height: hieght * 0.12,
                                              decoration: BoxDecoration(
                                                  color:
                                                      Color(kLightGrey.value),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 12.w),
                                                    width: 60.w,
                                                    height: 70.h,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(kLight.value),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    12))),
                                                    child: const Icon(
                                                      FontAwesome5Regular
                                                          .file_pdf,
                                                      color: Colors.red,
                                                      size: 40,
                                                    ),
                                                  ),
                                                  const WidthSpacer(width: 20),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ReusableText(
                                                          text:
                                                              'Upload Your Resume',
                                                          style: appStyle(
                                                              17,
                                                              Color(
                                                                  kDark.value),
                                                              FontWeight.w500)),
                                                      FittedBox(
                                                        child: Text(
                                                            "Please make sure to upload your resume in PDF",
                                                            style: appStyle(
                                                                8,
                                                                Color(kDarkGrey
                                                                    .value),
                                                                FontWeight
                                                                    .w500)),
                                                      )
                                                    ],
                                                  ),
                                                  const WidthSpacer(width: 1)
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                right: 0.w,
                                                child: const EditButton())
                                          ],
                                        ),
                                        const HeightSpacer(size: 20),
                                        // const SkillsWidget(),
                                        const HeightSpacer(size: 20),
                                        profile.isAgent
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // ReusableText(
                                                  //     text: 'Add Job',
                                                  //     style: appStyle(
                                                  //         15,
                                                  //         Color(
                                                  //             kDarkGrey.value),
                                                  //         FontWeight.w400)),
                                                  const HeightSpacer(size: 20),
                                                  CustomOutlineBtn(
                                                      onTap: () {
                                                        Get.to(() => const AddJobs());
                                                      },
                                                      width: width,
                                                      hieght: 40.h,
                                                      text: "Upload a Job",
                                                      color:
                                                          Color(kOrange.value),
                                                      color1:
                                                          Color(kOrange.value)),
                                                  const HeightSpacer(size: 10),
                                                  CustomOutlineBtn(
                                                      onTap: () {},
                                                      width: width,
                                                      hieght: 40.h,
                                                      text:
                                                          "Update Information",
                                                      color:
                                                          Color(kOrange.value),
                                                      color1:
                                                          Color(kOrange.value)),
                                                ],
                                              )
                                            : CustomOutlineBtn(
                                                onTap: () {},
                                                width: width,
                                                hieght: 40.h,
                                                text:
                                                    "Apply to become an Agent",
                                                color: Color(kOrange.value),
                                                color1: Color(kOrange.value)),
                                        const HeightSpacer(size: 20),
                                        CustomOutlineBtn(
                                            onTap: () {
                                              zoomNotifier.currentIndex = 0;
                                              loginNotifier.logout();
                                              Get.to(() => const MainScreen());
                                            },
                                            width: width,
                                            hieght: 40.h,
                                            text: "Proceed to logout",
                                            color: Color(kOrange.value),
                                            color1: Color(kOrange.value))
                                      ],
                                    ));
                              }
                            }),
                      )),
                ],
              ));
  }
}

class CircularAvatar extends StatelessWidget {
  const CircularAvatar(
      {super.key, required this.image, required this.w, required this.h});
  final String image;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(99.w)),
      child: CachedNetworkImage(
        imageUrl: image,
        width: w,
        height: h,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

// Positioned(
//                       right: 0, left: 0, bottom: 0, top: 0.h, 
                      
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical:20),
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           color: Color(kLightBlue.value),
//                         ),
//                         child:  Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircularAvatar(
//                                   image: image,
//                                   w: 50,
//                                   h: 50,
//                                 ),
//                                 const WidthSpacer(width: 20),
//                                 SizedBox(
//                                   height: 50,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .center,
//                                     children: [
//                                       // ReusableText(
//                                       //     text:
//                                       //         username,
//                                       //     style: appStyle(
//                                       //         15,
//                                       //         Color(kLight
//                                       //             .value),
//                                       //         FontWeight.w400)),
//                                       ReusableText(
//                                           text: "email",
//                                           style: appStyle(
//                                               15,
//                                               Color(kLight
//                                                   .value),
//                                               FontWeight.w500)),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             GestureDetector(
//                                 onTap: () {},
//                                 child:Padding(padding: EdgeInsets.only(top: 10.0.w),
//                                     child: Icon(Feather.edit, color: Color(kLight.value),))
//                                 )
//                           ],
//                         ),
//                       )
//                       ),