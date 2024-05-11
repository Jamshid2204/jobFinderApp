import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobfinderapp/models/request/auth/signup_model.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/custom_btn.dart';
import 'package:jobfinderapp/views/common/custom_textfield.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/screens/auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:jobfinderapp/controllers/signup_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Sign Up ",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: signUpNotifier.processing
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
                            text: 'Hello, Welcome',
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
                            controller: username,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name!.isEmpty || name.length > 3) {
                                return "Please enter a valid fullname";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Fullname",
                          ),
                          const HeightSpacer(size: 20),
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
                            hintText: "Password",
                            obscureText: signUpNotifier.obsecureText,
                            keyboardType: TextInputType.text,
                            validator: (password) {
                              if (signUpNotifier
                                  .passwordValidator(password ?? "")) {
                                return "Please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signUpNotifier.obsecureText = !signUpNotifier.obsecureText;
                              },
                              child: Icon(
                                signUpNotifier.obsecureText
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
                                Get.to(() => const LoginPage());
                              },
                              child: ReusableText(
                                text: "Login",
                                style: appStyle(
                                    14, Color(kDark.value), FontWeight.w500),
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          CustomButton(
                            onTap: () {
                              signUpNotifier.processing = true;

                              SignupModel model = SignupModel(
                                  username: username.text,
                                  email: email.text,
                                  password: password.text);

                              String newModel = signupModelToJson(model);
                              signUpNotifier.signUp(newModel);
                              // Get.to(() => const MainScreen());
                            },
                            text: "Register",
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
