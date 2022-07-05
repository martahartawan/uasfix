// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Layanan> layananFromJson(String str) =>
    List<Layanan>.from(json.decode(str).map((x) => Layanan.fromJson(x)));

String layananToJson(List<Layanan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
