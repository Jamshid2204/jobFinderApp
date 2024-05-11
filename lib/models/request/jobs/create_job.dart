import 'dart:convert';

String createJobsRequestToJson(CreateJobsRequest data) => json.encode(data.toJson());

class CreateJobsRequest {
    CreateJobsRequest({
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
    });

    final String title;
    final String location;
    final String company;
    final String agentName;
    final String description;
    final String category;
    final String salary;
    final String period;
    final String contract;
    final bool hiring;
    final String imageUrl;
    final String agentId;
    final List<String> requirements;

    Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "company": company,
        "agentName": agentName,
        "description": description,
        "category": category,
        "salary": salary,
        "period": period,
        "contract": contract,
        "hiring": hiring,
        "imageUrl": imageUrl,
        "agentId": agentId,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
    };
}
