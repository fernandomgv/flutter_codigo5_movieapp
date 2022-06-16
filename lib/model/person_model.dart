// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';

PersonModel personModelFromJson(String str) => PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {
  PersonModel({
    required  this.adult,
    required  this.alsoKnownAs,
    required  this.biography,
    required  this.birthday,
    required  this.deathday,
    required  this.gender,
    required  this.homepage,
    required  this.id,
    required  this.imdbId,
    required  this.knownForDepartment,
    required  this.name,
    required  this.placeOfBirth,
    required  this.popularity,
    required  this.profilePath,
  });

  bool adult;
  List<dynamic> alsoKnownAs;
  String biography;
  DateTime birthday;
  dynamic deathday;
  int gender;
  dynamic homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    adult: json["adult"],
    alsoKnownAs: List<dynamic>.from(json["also_known_as"].map((x) => x)),
    biography: json["biography"],
    birthday: json["birthday"] != null ? DateTime.parse(json["birthday"]) : DateTime.now() ,
    deathday: json["deathday"],
    gender: json["gender"],
    homepage: json["homepage"],
    id: json["id"],
    imdbId: json["imdb_id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    placeOfBirth: json["place_of_birth"] ?? "",
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
    "biography": biography,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "deathday": deathday,
    "gender": gender,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "known_for_department": knownForDepartment,
    "name": name,
    "place_of_birth": placeOfBirth,
    "popularity": popularity,
    "profile_path": profilePath,
  };
}
