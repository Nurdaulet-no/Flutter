import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'clothes.g.dart';

@HiveType(typeId: 1)
class Clothes{
  @HiveField(0)
  final String clothesId;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String price;
  
  @HiveField(3)
  final List<String> imagePaths;
  
  @HiveField(4)
  final String description;

  @HiveField(5)
  final List<String> size;

  @HiveField(6)
  final Map<String, String> characteristics;

  Clothes({
    required this.clothesId,
    required this.name,
    required this.price,
    required this.imagePaths,
    required this.description,
    required this.size,
    required this.characteristics
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
        clothesId: json['clothesId'],
        name: json['name'],
        price: json['price'],
        imagePaths: List<String>.from(json['imagePaths']),
        description: json['description'],
        size: List<String>.from(json['size']),
        characteristics: Map<String, String>.from(json['characteristics'])
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'clothesId': clothesId,
      'name': name,
      'price': price,
      'imagePaths': imagePaths,
      'description': description,
      'size': size,
      'characteristics': characteristics
    };
  }
}
