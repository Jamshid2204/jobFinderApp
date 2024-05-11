import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/zoom_provider.dart';
import 'package:jobfinderapp/services/helpers/auth_helper.dart';
import 'package:jobfinderapp/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {

  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }


  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;
  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }


  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

// triggered when the login button is clicked to show the loading widget
  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

// triggered when the fist time when user login to be prompted to the update profile page
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

  login(String model, ZoomNotifier zoomNotifier) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthHelper.login(model).then((response) {
      if (response == true) {
        processing = false;
        zoomNotifier.currentIndex = 0;
        Get.snackbar("Sucessfully logged in", "enjoy it",
            colorText: Color(kLight.value),
            backgroundColor: (const Color.fromARGB(98, 0, 240, 32)),
            icon: const Icon(Icons.add_alert));
        prefs.setBool("entrypoint", true);
        Get.to(() => const MainScreen());
      } else {
        processing = false;
        Get.snackbar("Failed to login", "Check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entrypoint = prefs.getBool("entrypoint") ?? false;
    loggedIn = prefs.getBool("loggedIn") ?? false;
    username = prefs.getString("username") ?? "";
    userUid = prefs.getString("uid") ?? "";
    profile = prefs.getString("profile") ?? "";
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", false);
    await prefs.remove("token");
  }
}
