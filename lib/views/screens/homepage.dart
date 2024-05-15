import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/drawer/drawer_widget.dart';
import 'package:jobfinderapp/views/common/heading_widget.dart';
import 'package:jobfinderapp/views/common/search.dart';
import 'package:jobfinderapp/views/screens/auth/login.dart';
import 'package:jobfinderapp/views/screens/auth/profile.dart';
import 'package:jobfinderapp/views/screens/home/widgets/popularJobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/views/screens/jobs/jobs_list_page.dart';
import 'package:jobfinderapp/views/screens/jobs/recent_list.dart';
import 'package:jobfinderapp/views/screens/search/searchpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPref();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    loginNotifier.loggedIn == true?
                    Get.to(() => const ProfilePage(drawer: false)):
                    Get.to(() => const LoginPage());
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      height: 25.w,
                      width: 25.w,
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(
              color: Colors.blue,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Search \nFind & Apply",
                style: appStyle(25, Color(kDark.value), FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              SearchWidget(
                onTap: () {
                  // Get.to(() => const SearchWidget());
                  Get.to(() => const SearchPage());
                },
              ),
              SizedBox(height: 15.h),
              HeadingWidget(
                text: "Popular Jobs",
                onTap: () {
                  Get.to(() => const JobListPage());
                },
              ),
              SizedBox(height: 10.h),
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  child: const PopularJobs()),
              SizedBox(height: 15.h),
              HeadingWidget(
                  text: "Recently Posted",
                  onTap: () {
                    Get.to(const JobListPage());
                  }),
              SizedBox(height: 10.h),
              const RecentJobs(),
            ]),
          ),
        ),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage> {
//   String imageUrl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';

//   Future<void> _refresh() async {
//     return Future.delayed(const Duration(seconds: 4));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: _refresh,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50.h),
//           child: CustomAppBar(
//             actions: [
//               Padding(
//                 padding: EdgeInsets.all(12.0.h),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.to(() => const ProfilePage(drawer: false));
//                   },
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(50)),
//                     child: CachedNetworkImage(
//                       height: 25.w,
//                       width: 25.w,
//                       imageUrl: imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//             child: Padding(
//               padding: EdgeInsets.all(12.0.h),
//               child: const DrawerWidget(
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Search \nFind & Apply",
//                     style: appStyle(25, Color(kDark.value), FontWeight.bold),
//                   ),
//                   SizedBox(height: 10.h),
//                   SearchWidget(
//                     onTap: () {
//                       Get.to(const SearchPage());
//                     },
//                   ),
//                   SizedBox(height: 15.h),
//                   HeadingWidget(
//                     text: "Popular Jobs",
//                     onTap: () {
//                       Get.to(const JobListPage());
//                     },
//                   ),
//                   SizedBox(height: 10.h),
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(12.w)),
//                     child: const PopularJobs(),
//                   ),
//                   SizedBox(height: 15.h),
//                   HeadingWidget(
//                     text: "Recently Posted",
//                     onTap: () {
//                       Get.to(const JobListPage());
//                     },
//                   ),
//                   SizedBox(height: 10.h),
//                   const RecentJobs(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.h),
//         child: CustomAppBar(
//           actions: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(12.h),
//               child: const CircleAvatar(
//                 radius: 15,
//                 backgroundImage: AssetImage('assets/images/user.png'),
//               ),
//             )
//           ],
//           child: Padding(
//             padding: EdgeInsets.all(12.0.h),
//             child: const DrawerWidget(
//               color: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const HeightSpacer(size: 10),
//                 Text(
//                   "Search \nFind & Apply",
//                   style: appStyle(40, Color(kDark.value), FontWeight.bold),
//                 ),
//                 const HeightSpacer(size: 40),
//                 SearchWidget(
//                   onTap: () {
//                     Get.to(() => const SearchPage());
//                   },
//                 ),
//                 const HeightSpacer(size: 30),
//                 HeadingWidget(
//                   text: "Popular Jobs",
//                   onTap: () {
//                     Get.to(() => const JobPage(title: "Facebook", id: "12"));
//                   },
//                 ),
//                 const HeightSpacer(size: 15),
//                 SizedBox(
//                   height: hieght * 0.28,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 4,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         // onTap: () {},
//                       );
//                     },
//                   ),
//                 ),
//                 const HeightSpacer(size: 20),
//                 HeadingWidget(
//                   text: "Recently Posted",
//                   onTap: () {},
//                 ),
//                 const HeightSpacer(size: 20),
//                 VerticalTile(
//                   onTap: () {}, job: null,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
