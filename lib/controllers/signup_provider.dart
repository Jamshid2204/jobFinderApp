import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/services/helpers/auth_helper.dart';
import 'package:jobfinderapp/views/screens/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {

  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  set obsecureText(bool newState) {
    _obsecureText = newState;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

  bool _firstTime = false;
  bool get firstTime => _firstTime;
  set firstTime(bool newValue) {
    _firstTime = newValue;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUp(String model) {
    AuthHelper.signup(model).then((response) {
      if (response == true) {
        processing = false;
        Get.snackbar("Succesfully signed up", "Now you can login",
            colorText: Color(kLight.value),
            backgroundColor: (const Color.fromARGB(98, 0, 240, 32)),
            icon: const Icon(Icons.add_alert));
        Get.offAll(() => const LoginPage());
      } else {
        processing = false;
        Get.snackbar("Failed to Sign Up", "Check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }
}
