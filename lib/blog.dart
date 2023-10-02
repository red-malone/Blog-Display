import 'package:hive/hive.dart';

part 'models/blog.g.dart';

@HiveType(typeId: 1)
class Blog {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String title;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String,
      title: json['title'] as String,
    );
  }
}
