import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobfinderapp/controllers/skills_provider.dart';
import 'package:jobfinderapp/controllers/zoom_provider.dart';
import 'package:jobfinderapp/models/request/skills/addskills_model.dart';
import 'package:jobfinderapp/models/response/auth/skills_model.dart';
import 'package:jobfinderapp/services/helpers/auth_helper.dart';
import 'package:jobfinderapp/views/common/exports.dart';
import 'package:jobfinderapp/views/common/height_spacer.dart';
import 'package:jobfinderapp/views/common/pages_loader.dart';
import 'package:jobfinderapp/views/common/width_spacer.dart';
import 'package:jobfinderapp/views/screens/auth/widgets/addSkills.dart';
import 'package:provider/provider.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  TextEditingController skills = TextEditingController();
  late Future<SkillsRes> userSkills;

  @override
  void initState() {
    userSkills = getSkills();
    super.initState();
  }

  Future<SkillsRes> getSkills() {
    var skills = AuthHelper.getSkills();
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: "Skills",
                  style: appStyle(14, Color(kDark.value), FontWeight.w600)),
              Consumer<SkillsNotifier>(
                  builder: (context, skillsNotifier, child) {
                print(skillsNotifier.addSkills);
                return skillsNotifier.addSkills != true
                    ? GestureDetector(
                        onTap: () {
                          skillsNotifier.setSkills = !skillsNotifier.addSkills;
                        },
                        child: const Icon(
                            MaterialCommunityIcons.plus_circle_outline,
                            size: 24),
                      )
                    : GestureDetector(
                        onTap: () {
                          skillsNotifier.setSkills = !skillsNotifier.addSkills;
                        },
                        child: const Icon(AntDesign.closecircleo, size: 20),
                      );
              })
            ],
          ),
        ),
        const HeightSpacer(size: 5),
        // skillsNotifier.addSkills != true ?
        // AddSkillsWidget(skill: userSkills,
        // onTap: () {
        //   AddSkill rawModel = AddSkill(skill: userSkills.text);
        //   var model = addSkillToJson(rawModel);
        //   AuthHelper.addSkills(model);
        //   userskills.clear();
        //   skillsNotifier.setSkills = !skillsNotifier.addSkills;
        //   userSkills = getSkills();
        // },)
        // :SizedBox(
        //   height: 32.w,
        //   child: FutureBuilder(future: userSkills, builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //             return const Center(
        //               child: CircularProgressIndicator.adaptive(),
        //             );
        //           } else if (snapshot.hasError) {
        //             return Text("Error type: + ${snapshot.error}");
        //           } else {
        //             var skills = snapshot.data;
        //             return ListView.builder(
        //               itemCount: 5,
        //               itemBuilder: (context, index){
        //                 var skill = skills[index];
        //               return GestureDetector(
        //                 onLongPress: () {
        //                   skillsNotifier.setSkillsId = skill.id;
        //                 },
        //                 onTap: () {
        //                   skillsNotifier.setSkillsId = '';
        //                 },
        //                 child: Container(
        //                   padding: EdgeInsets.all(5.w),
        //                   margin: EdgeInsets.all(4.w),
        //                   decoration: BoxDecoration(
        //                     color: Color(kLightGrey.value),
        //                     borderRadius: BorderRadius.all(Radius.circular(15.w)),
        //                   ),
        //                   child: Row(
        //                     children: [
        //                       ReusableText(
        //                         text: skill.skill, 
        //                         style: appStyle(10, Color(kDark.value), FontWeight.w500)
        //                         ),
        //                         const WidthSpacer(width: 5),
        //                         skillsNotifier.addSkillsId == skill.id?
        //                         GestureDetector(
        //                           onTap: (){
        //                             AuthHelper.deleteSkills(skillsNotifier.addSkillsId);
        //                             skillsNotifier.setSkillsId = '';
        //                             userSkills = getSkills();
        //                           },
        //                           child: Icon(AntDesign.delete,
        //                           size: 14,
        //                           color: Color(kDark.value),
        //                           ),
        //                         ): const SizedBox.shrink()
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             });
        //           }
        //   },),
        // )
      
      
      ],
    );
  }
}
