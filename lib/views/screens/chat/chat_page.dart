import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/controllers/agents_provider.dart';
import 'package:jobfinderapp/services/firebase_services.dart';
import 'package:jobfinderapp/utils/date.dart';
import 'package:jobfinderapp/views/common/BackBtn.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/auth/profile.dart';
import 'package:jobfinderapp/views/screens/chat/widgets/chat_left_item.dart';
import 'package:jobfinderapp/views/screens/chat/widgets/chat_right_item.dart';
import 'package:jobfinderapp/views/screens/chat/widgets/messaging_fields.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  FirebaseServices services = FirebaseServices();
  TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final itemController = ItemScrollController();
  var uuid = const Uuid();

  String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMHFxFWNUgd238aRdtOwlKnhr5yLTbq9vSCBtmhZSbUA&s';

  sendMessage() {
    var chat = Provider.of<AgentsNotifier>(context, listen: false).chat;

    Map<String, dynamic> message = {
      'message': messageController.text,
      'messageType': 'text',
      'profile': profile,
      'sender': userUid,
      'id': uuid.v4(),
      'time': Timestamp.now()
    };
    services.createChat(chat['chatRoomId'], message);
    messageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    print(uuid.v4());
    String chatRoomId =
        Provider.of<AgentsNotifier>(context, listen: false).chat['chatRoomId'];

    final Stream<QuerySnapshot> _typingStatus = FirebaseFirestore.instance
        .collection('typing')
        .doc(chatRoomId)
        .collection("typing")
        .snapshots();
    final Stream<QuerySnapshot> _chats = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('time')
        .snapshots();
    final Stream<QuerySnapshot> _userStatus = FirebaseFirestore.instance
        .collection('status')
        .doc('status')
        .collection(userUid)
        .snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(kLight.value),
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: const BackBtn(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _typingStatus,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error $snapshot.error");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Text('');
                        }
                        List<String> documentIds =
                            snapshot.data!.docs.map((doc) => doc.id).toList();

                        return ReusableText(
                            text: documentIds.isNotEmpty &&
                                    !documentIds.contains(userUid)
                                ? 'typing...'
                                : '',
                            style:
                                appStyle(9, Colors.black54, FontWeight.normal));
                      },
                    ),
                    ReusableText(
                        text: 'online',
                        style: appStyle(
                            9, Colors.green.shade600, FontWeight.normal))
                  ],
                ),
                Stack(
                  children: [
                    CircularAvatar(image: imageUrl, w: 30, h: 30),
                    Positioned(
                        child: CircleAvatar(
                      backgroundColor: Colors.green.shade600,
                      radius: 4,
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              top: 0.h,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 20.w, top: 10.w),
                width: width,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Color(kNewBlue.value),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                ),
                child: Column(
                  children: [
                    Consumer<AgentsNotifier>(
                      builder: (context, agentsNotifier, child) {
                        var jobDetails = agentsNotifier.chat['job'];
                        return Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          text: "Job Title",
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: "Salary",
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
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: jobDetails['company'],
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: jobDetails['title'],
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: jobDetails['salary'],
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                    ],
                                  )
                                ],
                              ),
                              const WidthSpacer(width: 20),
                              CircularAvatar(
                                  image: jobDetails['image_url'], w: 50, h: 50),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )),
          Positioned(
              top: 85.w,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: hieght * 0.8,
                decoration: BoxDecoration(
                    color: Color(kLight.value),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w),
                    )),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.w),
                      child: StreamBuilder(
                          stream: _chats,
                          builder: (BuildContext context, snapshot) {
                            print("snapshot data = ${snapshot.data?.docs}");
                            
                            if (snapshot.hasError) {
                              return Text("Error $snapshot.error");
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox.shrink();
                            } else if (snapshot.data!.docs.isEmpty != true) {
                              return const SizedBox.shrink();
                            }
                            int msgCount = snapshot.data!.docs.length;
                            return Column(
                              children: [
                                Container(
                                  height: hieght * 0.64,
                                  padding: EdgeInsets.all(8.w),
                                  child: ScrollablePositionedList.builder(
                                      itemCount: msgCount,
                                      itemBuilder: (context, index) {
                                        var message =
                                            snapshot.data!.docs[index];
                                        Timestamp lastChatTime =
                                            message['time'];
                                        DateTime chatTime =
                                            lastChatTime.toDate();
                                        print("id = ${message['id']}");
                                        print("message = ${message['message']}");
                                        print("hello");

                                        return Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: Column(
                                            children: [
                                              Text(
                                                duTimeLineFormat(chatTime),
                                                style: appStyle(10, Colors.grey,
                                                    FontWeight.normal),
                                              ),
                                              message['sender'] == userUid
                                                  ? chatRightItem(
                                                      message['messageType'],
                                                      message['message'],
                                                      message['profile'])
                                                  : chatLeftItem(
                                                      message['messageType'],
                                                      message['message'],
                                                      message['profile'])
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            );
                          }),
                    ),
                    Positioned(
                        bottom: 0.h,
                        child: MessagingField(
                          sendText: (){
                            sendMessage();
                          },
                          onTap: sendMessage,
                          messageController: messageController,
                          messageFocusNode: messageFocusNode,
                        ))
                  ],
                ),
              ))
        
        ],
      )),
    
    );
  }
}
