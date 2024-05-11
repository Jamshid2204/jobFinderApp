import 'package:flutter/material.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/views/common/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:provider/provider.dart';

import '../../common/drawer/drawer_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Chat",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(
              color: Color.fromARGB(255, 16, 155, 23),
            ),
          ),
        ),
      ),
      body: Center(
        child: loginNotifier.loggedIn == false
            ? const NonUser()
            : ReusableText(
                text: "Chat page",
                style: appStyle(30, Color(kDark.value), FontWeight.bold)),
      ),
    );
  }
}
