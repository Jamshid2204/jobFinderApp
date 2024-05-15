import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/controllers/agents_provider.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/screens/jobs/widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class AgentJobs extends StatelessWidget {
  const AgentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentsNotifier>(builder: (context, agentsNotifier, child) {
      agentsNotifier.getAgentJobs(agentsNotifier.agent!.uid);
      return FutureBuilder<List<JobsResponse>>(
          future: agentsNotifier.agentJobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const PageLoader();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var jobs = snapshot.data;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ListView.builder(
                  itemCount: jobs!.length,
                  itemBuilder: (context, index){
                    var job = jobs[index];
                    return UploadedTile(job: job);
                  }),
                );
            }
          });
    });
  }
}
