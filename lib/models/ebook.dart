import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Ebook ebookFromJson(String str) => Ebook.fromJson(json.decode(str));

String ebookToJson(Ebook data) => json.encode(data.toJson());

class Ebook{
  
  Ebook({
    required this.id,
    required this.title,
    required this.author,
    required this.link,
    required this.description,
    required this.image,
    required this.genre,
  });

  final int id;
  final String title;
  final String author;
  final String link;
  final String description;
  final String image;
  final List<dynamic> genre; // Change the type to List<dynamic>

  factory Ebook.fromJson(Map<String, dynamic> json) => Ebook(
        id: json["id"],
        link: json["link"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        image: json["image"],
        genre: json["genre"], // Assign the genre property directly without casting to List<String>
      );
  
  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "title": title,
        "author": author,
        "description": description,
        "image": image,
        "genre": List<dynamic>.from(genre),
      };

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}