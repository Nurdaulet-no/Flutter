import 'package:hive/hive.dart';

part 'about_content.g.dart';

@HiveType(typeId: 3)
class AboutContent {

  @HiveField(0)
  String textContent = "";
}