import 'dart:convert';


BookMarkReqRes bookMarkReqResFromJson(String str) => BookMarkReqRes.fromJson(json.decode(str));

String bookMarkReqResToJson(BookMarkReqRes data) => json.encode(data.toJson());



class BookMarkReqRes {
    final String job;

    BookMarkReqRes({
        required this.job,
    });

    factory BookMarkReqRes.fromJson(Map<String, dynamic> json) => BookMarkReqRes(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
      "job": job,
    };

}
