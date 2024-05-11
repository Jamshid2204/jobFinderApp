import 'package:flutter/material.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/controllers/onboarding_provider.dart';
import 'package:jobfinderapp/views/common/drawer/drawer_widget.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:jobfinderapp/views/screens/device_mgt/widgets/device_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/views/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';

import 'package:jobfinderapp/controllers/zoom_provider.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    var zoomnotifier = Provider.of<ZoomNotifier>(context);
    var onboardnotifier = Provider.of<OnBoardNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Device Management",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(
              color: Color.fromARGB(255, 16, 155, 23),
            ),
          ),
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const HeightSpacer(size: 50),
                        Text(
                          'You are logged in into your account on these device',
                          style: appStyle(
                              16, Color(kDark.value), FontWeight.normal),
                        ),
                        const HeightSpacer(size: 50),
                        DeviceInfo(
                          location: 'Nairobi KE',
                          device: 'HP Pro',
                          platform: 'Windows Desktop',
                          date: loginDate,
                          ipAdress: '192.7.8.1:1000',
                        ),
                        const HeightSpacer(size: 50),
                        DeviceInfo(
                          location: 'Voi KE',
                          device: 'Samsung A12',
                          platform: 'Android Application',
                          date: loginDate,
                          ipAdress: '180.7.8.1:1000',
                        ),
                      ],
                    ),
                  ),
                  Consumer<LoginNotifier>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: GestureDetector(
                          onTap: () {
                            zoomnotifier.currentIndex = 0;
                            onboardnotifier.isLastPage = false;
                            Get.to(() => const OnBoardingScreen());
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ReusableText(
                              text: "Sign Out of all devices",
                              style: appStyle(
                                  16, Color(kOrange.value), FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
