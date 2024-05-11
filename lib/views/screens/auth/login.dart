import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/zoom_provider.dart';
import 'package:jobfinderapp/models/request/auth/login_model.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/custom_btn.dart';
import 'package:jobfinderapp/views/common/custom_textfield.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/screens/auth/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:jobfinderapp/controllers/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        loginNotifier.getPref();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Login ",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: loginNotifier.processing
              ? const PageLoader()
              : BuildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          const HeightSpacer(size: 50),
                          ReusableText(
                            text: 'Welcome Back',
                            style: appStyle(
                              30,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          ReusableText(
                            text:
                                'Fill in the details to login to your account',
                            style: appStyle(
                              16,
                              Color(kDarkGrey.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          CustomTextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email",
                            validator: (email) {
                              if (email!.isEmpty ||
                                  !email.contains("@") ||
                                  !email.contains(".")) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            controller: password,
                            obscureText: loginNotifier.obscureText,
                            keyboardType: TextInputType.text,
                            hintText: "Password",
                            validator: (password) {
                              if (password!.isEmpty || password.length < 8) {
                                return "Please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                loginNotifier.obscureText =
                                    !loginNotifier.obscureText;
                              },
                              child: Icon(
                                loginNotifier.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(kDark.value),
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const RegistrationPage());
                              },
                              child: ReusableText(
                                text: "Register",
                                style: appStyle(
                                    14, Color(kDark.value), FontWeight.w500),
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          Consumer<ZoomNotifier>(
                            builder: (context, zoomNotifier, child) {
                              return CustomButton(
                                onTap: () {
                                  loginNotifier.processing = true;
                                  LoginModel model = LoginModel(
                                      email: email.text,
                                      password: password.text);
                                  String newModel = loginModelToJson(model);
                                  loginNotifier.login(newModel, zoomNotifier);
                                },
                                text: "Login",
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
