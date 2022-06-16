// To parse this JSON data, do
//
//     final genresModel = genresModelFromJson(jsonString);

import 'dart:convert';

GenresModel genresModelFromJson(String str) => GenresModel.fromJson(json.decode(str));

String genresModelToJson(GenresModel data) => json.encode(data.toJson());

class GenresModel {
  GenresModel({
    required this.id,
    required this.name,
    this.isSelected=false,
  });

  int id;
  String name;
  bool isSelected=false;
  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
