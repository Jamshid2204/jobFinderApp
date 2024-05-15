import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/agents_provider.dart';
import 'package:jobfinderapp/models/request/agents/agents.dart';
import 'package:jobfinderapp/models/response/agent/get_agent.dart';
import 'package:jobfinderapp/services/helpers/agent_helper.dart';
import 'package:jobfinderapp/views/common/BackBtn.dart';
import 'package:jobfinderapp/views/common/app_style.dart';
import 'package:jobfinderapp/views/common/reusable_text.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/agent/agent_jobs.dart';
import 'package:jobfinderapp/views/screens/auth/profile.dart';
import 'package:jobfinderapp/views/screens/chat/chatlist.dart';
import 'package:provider/provider.dart';

class AgentDetails extends StatelessWidget {
  const AgentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var agentsNotifier = Provider.of<AgentsNotifier>(context);
    print(agentsNotifier.agent!.username);
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: const BackBtn(color: Colors.cyan,),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 10,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                height: 140.h,
                decoration: BoxDecoration(
                    color: Color(kNewBlue.value),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w))),
                child: Column(
                  children: [
                    Consumer<AgentsNotifier>(
                      builder: (context, agentsNotifier, child) {
                        var agent = agentsNotifier.agent;
                        var agentInfo = agentsNotifier.getAgentInfo(agent!.uid);
                        return Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: "Company",
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: "Address",
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: "Working Hours",
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Container(
                                      height: 60.w,
                                      width: 1.w,
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  FutureBuilder<GetAgent>(
                                    
                                      future:
                                          AgentHelper.getAgentInfo(agent.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox.shrink();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          var data = snapshot.data;
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                  text: data!.company,
                                                  style: appStyle(
                                                      12,
                                                      Color(kLight.value),
                                                      FontWeight.w500)),
                                              ReusableText(
                                                  text: data!.hqAddress,
                                                  style: appStyle(
                                                      12,
                                                      Color(kLight.value),
                                                      FontWeight.w500)),
                                              ReusableText(
                                                  text: data!.workingHrs,
                                                  style: appStyle(
                                                      12,
                                                      Color(kLight.value),
                                                      FontWeight.w500)),
                                            ],
                                          );
                                        }
                                      })
                                ],
                              ),
                              const WidthSpacer(width: 20),
                              CircularAvatar(image: agent.profile, w: 50, h: 50),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              
              )),
          Positioned(
              top: 100.h,
              right: 0,
              left: 0,
              child: Container(
                width: width,
                height: hieght,
                decoration: BoxDecoration(
                    color: const Color(0xFFEffffc),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w))
                        ),
                        child: const AgentJobs(),
              )
              )
        ],
      ),
    );
  }
}
