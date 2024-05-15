import 'package:http/http.dart' as https;
// import 'package:flutter_nodejs_job_app/models/response/jobs/jobs_response';
import 'package:jobfinderapp/models/response/jobs/get_job.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    print(url);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      // 'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");
    print("url = ${url}");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      return job;
      print("passed");
    } else {
      throw Exception('Failed to load job');
    }
  }

  static Future<List<JobsResponse>> getRecent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs, {"new": "true"});
    print(url);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<List<JobsResponse>> searchJobs(String query) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$query");
    print(url);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }


    static Future<bool> createJob(String model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, Config.jobs);
      print(url);
      print(token);
      var response = await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 201) {
        print("Job added");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

      static Future<bool> updateJob(String model, String jobid) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobid");
      print(url);
      print(token);
      var response = await client.put(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        print("Job updated");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
