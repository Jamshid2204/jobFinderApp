import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/views/common/textfield.dart';

class AddSkillsWidget extends StatelessWidget {
  const AddSkillsWidget({super.key, required this.skill, this.onTap});
  final TextEditingController skill;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      height: 62,
      child: buildtextfield(
        hintText: 'Add New Skill',
        controller: skill,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            Entypo.upload_to_cloud,
            size: 30,
            color: Color(kNewBlue.value),
          ),
        ),
        onSubmitted: (p0) {
          if(p0!.isEmpty){
            return 'Please enter skill name';
          }else{
            return null;
          }
        },
      ),
    );
  }
}
