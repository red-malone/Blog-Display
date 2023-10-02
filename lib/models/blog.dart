class Blog {
  final String id;
  final String imageUrl;
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
