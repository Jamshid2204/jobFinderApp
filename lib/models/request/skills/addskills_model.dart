import 'dart:convert';

AddSkill addSkillFromJson(String str) => AddSkill.fromJson(json.decode(str));

String addSkillToJson(AddSkill data) => json.encode(data.toJson());

class AddSkill {
    final String skill;

    AddSkill({
        required this.skill,
    });

    factory AddSkill.fromJson(Map<String, dynamic> json) => AddSkill(
        skill: json["skill"],
    );

    Map<String, dynamic> toJson() => {
        "skill": skill,
    };
}
