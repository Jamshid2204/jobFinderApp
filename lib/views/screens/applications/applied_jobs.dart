import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/models/response/applied/applied.dart';
import 'package:jobfinderapp/services/helpers/applied_helper.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:jobfinderapp/views/common/drawer/drawer_widget.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/screens/applications/widgets/applied_tile.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:provider/provider.dart';

class AppliedJobs extends StatelessWidget {
  const AppliedJobs({super.key});

  @override
  Widget build(BuildContext context){
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Applied jobs",
          color: Color(kNewBlue.value),
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(
              color: Color(kLight.value),
            ),
          ),
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w)),
                              color: const Color(0xFFEFFFFC)),
                          child: BuildStyleContainer(
                              context,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: FutureBuilder<List<Applied>>(
                                  future: AppliedtHelper.getApplied(),
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const PageLoader();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      var jobs = snapshot.data;
                                      return ListView.builder(
                                          itemCount: jobs!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final job = jobs[index].job;
                                            return AppliedTile(job: job);
                                          });
                                    }
                                  }),
                                ),
                              )),
                        ))
                  ],
                )
              
    );
  }
}