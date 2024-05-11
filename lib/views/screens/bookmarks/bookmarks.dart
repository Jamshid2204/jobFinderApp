import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/controllers/bookmark_provider.dart';
import 'package:jobfinderapp/controllers/login_provider.dart';
import 'package:jobfinderapp/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/styled_container.dart';
import 'package:jobfinderapp/views/screens/auth/non_user.dart';
import 'package:jobfinderapp/views/screens/bookmarks/widgets/bookmark_widget.dart';
import 'package:provider/provider.dart';
import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          color: Color(kNewBlue.value),
          text: !loginNotifier.loggedIn ? "" : "Bookmarks",
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
          : Consumer<BookNotifier>(
              builder: (context, bookNotifier, child) {
                bookNotifier.getBookMarks();
                var bookmarks = bookNotifier.getBookMarks();
                return Stack(
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
                                child: FutureBuilder<List<AllBookMarks>>(
                                  future: bookmarks,
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const PageLoader();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      var processedBooks = snapshot.data;
                                      return ListView.builder(
                                          itemCount: processedBooks!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final bookmark =
                                                processedBooks[index];

                                            return BookMarkTile(
                                                bookmarks: bookmark);
                                          });
                                    }
                                  }),
                                ),
                              )),
                        ))
                  ],
                );
              },
            ),
    );
  }
}
