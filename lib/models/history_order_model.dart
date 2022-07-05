// To parse this JSON data, do
//
//     final History = HistoryFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    History({
        required this.id,
        required this.invoice,
        required this.userId,
        required this.layananId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.layanan,
    });

    int id;
    String invoice;
    String userId;
    String layananId;
    DateTime createdAt;
    DateTime updatedAt;
    User user;
    Layanan layanan;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        invoice: json["invoice"],
        userId: json["user_id"],
        layananId: json["layanan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        layanan: Layanan.fromJson(json["layanan"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "user_id": userId,
        "layanan_id": layananId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "layanan": layanan.toJson(),
    };
}

class Layanan {
    Layanan({
      required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.createdAt,
      required this.updatedAt,
    });

    int id;
    String name;
    String description;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory Layanan.fromJson(Map<String, dynamic> json) => Layanan(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class User {
    User({
      required this.id,
      required this.name,
      required this.email,
      required this.emailVerifiedAt,
      required this.createdAt,
      required this.updatedAt,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
