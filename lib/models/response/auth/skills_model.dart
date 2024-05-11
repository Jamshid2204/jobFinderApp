import 'dart:convert';

SkillsRes skillsResFromJson(String str) => SkillsRes.fromJson(json.decode(str));

String skillsResToJson(SkillsRes data) => json.encode(data.toJson());

class SkillsRes {
    final String id;
    final String username;
    final String email;
    final bool isAdmin;
    final bool isAgent;
    final bool skills;
    // final List<String> skills;
    // final DateTime updatedAt;
    // final String location;
    // final String phone;
    final String profile;

    SkillsRes({
        required this.id,
        required this.username,
        required this.email,
        required this.isAdmin,
        required this.isAgent,
        required this.skills,
        // required this.updatedAt,
        // required this.location,
        // required this.phone,
        required this.profile,
    });

    factory SkillsRes.fromJson(Map<String, dynamic> json) => SkillsRes(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json["skills"],
        // skills: List<String>.from(json["skills"].map((x) => x)),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // location: json["location"],
        // phone: json["phone"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": skills,
        // "skills": List<dynamic>.from(skills.map((x) => x)),
        // "updatedAt": updatedAt.toIso8601String(),
        // "location": location,
        // "phone": phone,
        "profile": profile,
    };
}
