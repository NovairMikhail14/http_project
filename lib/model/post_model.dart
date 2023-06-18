
import 'dart:convert';

// List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

// String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int userId;
    int id;
    String title;
    String body;

    Post({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"]??0,
        id: json["id"]??0,
        title: json["title"]??"",
        body: json["body"]??"",
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
