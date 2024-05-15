import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
    GetJobRes({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        required this.agentName,
        required this.description,
        required this.category,
        required this.salary,
        required this.contract,
        required this.hiring,
        required this.period,
        required this.imageUrl,
        required this.agentId,
        required this.requirements,
        // required this.updatedAt,
    });

    final String id;
    final String title;
    final String location;
    final String company;
    final String agentName;
    final String description;
    final String category;
    final String salary;
    final String contract;
    final bool hiring;
    final String period;
    final String imageUrl;
    final String agentId;
    final List<String> requirements;
    // final DateTime updatedAt;

    factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        agentName: json["agentName"],
        description: json["description"],
        category: json["category"],
        salary: json["salary"],
        contract: json["contract"],
        hiring: json["hiring"],
        period: json["period"],
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        // updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "agentName": agentName,
        "description": description,
        "category": category,
        "salary": salary,
        "contract": contract,
        "hiring": hiring,
        "period": period,
        "imageUrl": imageUrl,
        "agentId": agentId,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        // "updatedAt": updatedAt.toIso8601String(),
    };
}
