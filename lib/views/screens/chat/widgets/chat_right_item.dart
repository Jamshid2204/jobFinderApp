import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/screens/auth/profile.dart';

Widget chatRightItem (String type, String message, String profile){
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.fromLTRB(15.w, 10.w, 0.w, 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(constraints: BoxConstraints(
              maxHeight: 230.w,
              minHeight: 40.w
            ),
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3281E3),
                    Color.fromARGB(255, 131, 182, 245),
                  ],
                  transform: GradientRotation(120),
                )
              ),
              child: Text(message, style: appStyle(12, const Color.fromARGB(255, 0, 0, 0), FontWeight.normal),),
              
            ),
            )
          ],
        ),
      ),
      Positioned(left: 4, child: CircularAvatar(image: profile, w: 20, h: 20,))
    ],
  );
}