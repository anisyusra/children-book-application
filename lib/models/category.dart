import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {

  String? id;
  final String genre;


  Category({
    this.id,
    required this.genre
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        genre: json["genre"]
      );
  
  Map<String, dynamic> toJson() => {
        "id": id,
        "genre": genre,
      };

}