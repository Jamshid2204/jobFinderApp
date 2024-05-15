import 'package:http/http.dart' as https;
import 'package:jobfinderapp/models/request/agents/agents.dart';
import 'package:jobfinderapp/models/response/agent/get_agent.dart';
import 'package:jobfinderapp/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobfinderapp/models/response/bookmarks/bookmark.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentHelper {
  static var client = https.Client();

  static Future<BookMark> addBookmark(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.post(url, headers: requestHeaders, body: model);

    if (response.statusCode == 200) {
      var bookmark = bookMarkFromJson(response.body);
      return bookmark;
    } else {
      print("token = ${token}");
      print("url = ${url}");
      throw Exception('Failed to add bookmark');
      // return ;
    }
  }

  static Future<List<Agents>> getAllAgents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.getAgentsUrl);
    print(url);
    var res = await client.get(url, headers: requestHeaders);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var agents = agentsFromJson(res.body);
      return agents;
    } else {
      print(res.statusCode);
      throw Exception("Failed to get agents");
    }
  }

    static Future<List<JobsResponse>> getAgentJobs(String uid) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/agent/$uid");
    print(url);
    var res = await client.get(url, headers: requestHeaders);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var agents = jobsResponseFromJson(res.body);
      return agents;
    } else {
      print(res.statusCode);
      throw Exception("Failed to get agents");
    }
  }

    static Future<GetAgent> getAgentInfo(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("getagentinfo token = ");
    print(token);
    print(uid);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.getAgentsUrl}/$uid");
    print(url);
    var res = await client.get(url, headers: requestHeaders);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var agent = getAgentFromJson(res.body);
      return agent;
    } else {
      print(res.statusCode);
      throw Exception("Failed to get agent");
    }
  }

  static Future<BookMark?> getBookmark(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return null;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "${Config.singleBookmarkUrl}/$jobId");
      print(url);
      print(token);
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        var bookmark = bookMarkFromJson(response.body);
        print("bookmark exists");
        return bookmark;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

}
