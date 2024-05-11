import 'package:flutter/material.dart';
import 'package:jobfinderapp/views/common/custom_outline_btn.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/screens/auth/login.dart';
import 'package:jobfinderapp/views/screens/auth/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: hieght,
        width: width,
        color: Color(kLightBlue.value),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/page3.png'),
            const HeightSpacer(size: 20),
            ReusableText(
              text: "Welcome To JobsApp",
              style: appStyle(30, Color(kLight.value), FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                'We help you find your dream job according to your skillset location and preference to build your career',
                textAlign: TextAlign.center,
                style: appStyle(14, Color(kLight.value), FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomOutlineBtn(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('EntryPoint', true);
                    Get.to(() => const LoginPage());
                  },
                  text: 'Login',
                  width: width * 0.4,
                  hieght: hieght * 0.06,

                  color1: Color(kLight.value), color: Color(kLight.value),
                  height: 10,
                  //color2: Color(value),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegistrationPage());
                  },
                  child: Container(
                    width: width * 0.4,
                    height: hieght * 0.06,
                    color: Color(kLight.value),
                    child: Center(
                      child: ReusableText(
                        text: 'Sign Up',
                        style: appStyle(
                          16,
                          Color(kLightBlue.value),
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(size: 30),

            // GestureDetector(
            //       onTap: () async {
            //         final SharedPreferences prefs = await SharedPreferences.getInstance();

            //         prefs.setBool("enrtypoint", true);
            //         Get.to(() => const MainScreen());
            //       },
            //       child: Container(
            //         width: width * 0.9,
            //         height: hieght * 0.05,
            //         color: Color(kLight.value),
            //         child: Center(
            //           child: ReusableText(
            //             text: 'Continue as guest',
            //             style: appStyle(
            //               16,
            //               Color(kLightBlue.value),
            //               FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),

            CustomOutlineBtn(
              onTap: () async {
                print("clicked ");
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                prefs.setBool("entrypoint", true);
                Get.to(() => const MainScreen());
              },
              hieght: hieght * 0.05,
              width: width * 0.9,
              text: "Continue as guest",
              color: Color(kLight.value),
              color1: Color(kLight.value),
            )
          ],
        ),
      ),
    );
  }
}
