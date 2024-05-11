import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/jobs_provider.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/views/screens/jobs/job_page.dart';
import 'package:jobfinderapp/views/screens/jobs/jobs_horizontal_tile.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatelessWidget {
  const PopularJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJobs();
      return SizedBox(
          height: hieght * 0.24,
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.jobList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: + ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const Text("No jobs avialable!");
                } else {
                  final jobs = snapshot.data;

                  return ListView.builder(
                    itemCount: jobs!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var job = jobs[index];
                      return JobsHorizontalTile(
                        job: job,
                        onTap: () {
                          Get.to(JobPage(title: job.title, id: job.id, agentName: job.agentName,));
                        },
                      );
                    },
                  );
                }
              }));
    });
  }
}
