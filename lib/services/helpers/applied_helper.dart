import 'package:http/http.dart' as https;
import 'package:jobfinderapp/models/response/applied/applied.dart';
import 'package:jobfinderapp/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppliedtHelper {
  static var client = https.Client();

  static Future<bool> applyJob(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.applyUrl);

    var response = await client.post(url, headers: requestHeaders, body: model);

    if (response.statusCode == 200) {
      return true;
    } else {
      print("token = ${token}");
      print("url = ${url}");
      // throw Exception('Failed to apply to a job');
      return false;
    }
  }

  static Future<List<Applied>> getApplied() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

          if (token == null) {
        throw Exception("No token had");;
      }

    var url = Uri.https(Config.apiUrl, Config.applyUrl);
    print(url);
    var res = await client.get(url, headers: requestHeaders);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var applied = appliedFromJson(res.body);
      return applied;
    } else {
      print(res.statusCode);
      throw Exception("Failed to get applied");
    }
  }
}
