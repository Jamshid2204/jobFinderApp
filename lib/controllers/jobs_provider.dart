import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jobfinderapp/constants/app_constants.dart';
// import 'package:jobfinderapp/models/request/bookmarks/bookmarks_model.dart';
// import 'package:jobfinderapp/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobfinderapp/models/response/jobs/get_job.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<List<JobsResponse>> recentJobs;
  late Future<GetJobRes> job;

  Future<List<JobsResponse>> getJobs() {
    jobList = JobsHelper.getJobs();
    return jobList;
  }

  Future<List<JobsResponse>> getRecent() {
    recentJobs = JobsHelper.getJobs();
    return jobList;
  }

  Future<GetJobRes> getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
    return job;
  }
}
