import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/models/response/auth/login_res_model.dart';
import 'package:jobfinderapp/models/response/auth/profile_model.dart';
import 'package:jobfinderapp/models/response/auth/skills_model.dart';
import 'package:jobfinderapp/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);
      print(url);
      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 201) {
        // var jobList = jobsResponseFromJson(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(String model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    print(url);
    var response = await client.post(url, headers: requestHeaders, body: model);

    if (response.statusCode == 200) {
      print("success login");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = loginResponseModelFromJson(response.body);
      print(user.username);
      await prefs.setString("token", user.userToken);
      await prefs.setString("userId", user.id);
      await prefs.setString("uid", user.uid);
      await prefs.setBool("isAgent", user.isAgent);
      await prefs.setString("profile", user.profile);
      await prefs.setString("username", user.username);
      await prefs.setBool("loggedIn", true);

      return true;
    } else {
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No auth token provided");
    } else {
      print("token = $token");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    print(url);

    try {
      var response = await client.get(url, headers: requestHeaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var profile = profileResFromJson(response.body);
        print(response.body);
        return profile;
      } else {
        throw Exception("Failed to get profile 1");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to get profile 2.1");
    }
  }

  static Future<SkillsRes> getSkills() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No auth token provided");
    } else {
      print("token = $token");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.skillsUrl);
    print(url);

    try {
      var response = await client.get(url, headers: requestHeaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var skills = skillsResFromJson(response.body);
        print(response.body);
        return skills;
      } else {
        throw Exception("Failed to get skills 1");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to get skills 2.1");
    }
  }

  static Future<bool> deleteSkills(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No auth token provided");
    } else {
      print("token = $token");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.skillsUrl}/$id");
    print(url);

    try {
      var response = await client.delete(url, headers: requestHeaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

    static Future<bool> addSkills(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No auth token provided");
    } else {
      print("token = $token");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.skillsUrl);
    print(url);

    try {
      var response = await client.post(url, headers: requestHeaders, body: model);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}



  //   try {
  //     var response = await https.get(
  //       Uri.parse('https://privatejobapp-production.up.railway.app/api/users'),
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer $token',
  //       },
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       var profile = profileResFromJson(response.body);
  //       return profile;
  //     } else {
  //       throw Exception("Failed to get profile 1");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed to get profile 2");
  //   }