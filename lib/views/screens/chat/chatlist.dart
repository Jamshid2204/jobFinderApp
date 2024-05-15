import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/controllers/agents_provider.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/models/request/agents/agents.dart';
import 'package:jobfinderapp/services/firebase_services.dart';
import 'package:jobfinderapp/utils/date.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/loader.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/agent/agent_details.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:jobfinderapp/views/screens/auth/profile.dart';
import 'package:jobfinderapp/views/screens/chat/chat_page.dart';
import 'package:provider/provider.dart';
import '../../common/drawer/drawer_widget.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  String image =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMHFxFWNUgd238aRdtOwlKnhr5yLTbq9vSCBtmhZSbUA&s';

  FirebaseServices services = FirebaseServices();

  final Stream<QuerySnapshot> _chat = FirebaseFirestore.instance
      .collection('chats')
      .where('users', arrayContains: userUid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    print("UserUid =  ${userUid}");
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: DrawerWidget(
            color: Color(kLight.value),
          ),
        ),
        title: loginNotifier.loggedIn == false
            ? const SizedBox.shrink()
            : TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                    color: const Color(0x00BABABA),
                    borderRadius: BorderRadius.circular(25.w)),
                labelColor: Color(kLight.value),
                unselectedLabelColor: Colors.grey.withOpacity(.5),
                padding: EdgeInsets.all(3.w),
                labelStyle: appStyle(12, Color(kLight.value), FontWeight.w500),
                tabs: const [
                    Tab(
                      text: "MESSAGE",
                    ),
                    Tab(
                      text: "ONLINE",
                    ),
                    Tab(
                      text: "GROUPS",
                    ),
                  ]),
      ),
      body: Center(
        child: loginNotifier.loggedIn == false
            ? const NonUser()
            : TabBarView(controller: tabController, children: [
                Stack(
                  children: [
                    Positioned(
                        top: 20,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 0.w,
                            left: 25.w,
                            right: 0.w,
                          ),
                          height: 210.h,
                          decoration: BoxDecoration(
                              color: Color(kNewBlue.value),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: "Agents and Companies",
                                      style: appStyle(12, Color(kLight.value),
                                          FontWeight.normal)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        AntDesign.ellipsis1,
                                        color: Color(kLight.value),
                                      ))
                                ],
                              ),
                              Consumer<AgentsNotifier>(
                                  builder: (context, agentsNotifier, child) {
                                var agents = agentsNotifier.getAgents();
                                return FutureBuilder<List<Agents>>(
                                  future: agents,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(
                                        height: 90.h,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 7,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: buildAgentAvatar(
                                                    "Agent $index", image),
                                              );
                                            }),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return SizedBox(
                                        height: 90.h,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              var agent = snapshot.data![index];
                                              return GestureDetector(
                                                onTap: () {
                                                  agentsNotifier.agent = agent;
                                                  Get.to(() =>
                                                      const AgentDetails());
                                                },
                                                child: buildAgentAvatar(
                                                    agent.username,
                                                    agent.profile),
                                              );
                                            }),
                                      );
                                    }
                                  },
                                );
                              })
                            ],
                          ),
                        )),
                    Positioned(
                        top: 150.h,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: width,
                          height: hieght,
                          decoration: BoxDecoration(
                              color: Color(kLight.value),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w))),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _chat,
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error $snapshot.error");
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const PageLoader();
                              } else if (snapshot.data!.docs.isEmpty) {
                                return const NoSearchResults(
                                    text: "No chats available");
                              }

                              final chatList = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: chatList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w),
                                itemBuilder: (context, index) {
                                  final chat = chatList[index].data()
                                      as Map<String, dynamic>;
                                  Timestamp lastChatTime = chat['lastChatTime'];
                                  DateTime lastChatDateTime =
                                      lastChatTime.toDate();
                                  return Consumer<AgentsNotifier>(builder:
                                      (context, agentsNotifier, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (chat['sender'] != userUid) {
                                          services
                                              .updateCount(chat['chatRoomId']);
                                        } else {}
                                        agentsNotifier.chat = chat;
                                        Get.to(() => const ChatPage());
                                      },
                                      child: buildChatRow(
                                          username == chat['name']
                                              ? chat['agentName']
                                              : chat['name'],
                                          chat["lastChat"],
                                          chat["profile"],
                                          chat['read'] == true ? 0 : 1,
                                          lastChatDateTime),
                                    );
                                  });
                                },
                              );
                            },
                          ),
                        ))
                  ],
                ),

                // Container(
                //   height: hieght,
                //   width: width,
                //   color: Colors.blueAccent,
                // ),
                Container(
                  height: hieght,
                  width: width,
                  color: Colors.greenAccent,
                ),
                Container(
                  height: hieght,
                  width: width,
                  color: Colors.amberAccent,
                ),
              ]),
      ),
    );
  }
}

Padding buildAgentAvatar(String name, String filename) {
  return Padding(
    padding: EdgeInsets.only(right: 20.w),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(99.w)),
              border: Border.all(width: 2, color: Color(kLight.value))),
          child: CircularAvatar(image: filename, w: 50, h: 50),
        ),
        const HeightSpacer(size: 5),
        ReusableText(
            text: name,
            style: appStyle(11, Color(kLight.value), FontWeight.normal))
      ],
    ),
  );
}

Column buildChatRow(
    String name, String message, String filename, int msgCount, time) {
  return Column(
    children: [
      FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularAvatar(image: filename, w: 50, h: 50),
                const WidthSpacer(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: name,
                        style: appStyle(12, Colors.grey, FontWeight.w400)),
                    const HeightSpacer(size: 5),
                    SizedBox(
                        width: width * 0.65,
                        child: ReusableText(
                            text: message,
                            style: appStyle(12, Colors.grey, FontWeight.w400))),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 5.w, top: 5.w),
              child: Column(
                children: [
                  ReusableText(
                      text: duTimeLineFormat(time),
                      style: appStyle(10, Colors.black, FontWeight.normal)),
                  const HeightSpacer(size: 15),
                  if (msgCount > 0)
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: Color(kNewBlue.value),
                      child: ReusableText(
                        text: msgCount.toString(),
                        style:
                            appStyle(8, Color(kLight.value), FontWeight.normal),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
      const Divider(
        indent: 70,
        height: 20,
      )
    ],
  );
}
