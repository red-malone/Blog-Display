import 'package:blogs/models/blog.dart';
import 'package:flutter/material.dart';

class BlogListWidget extends StatelessWidget {
  final List<Blog> blogs;

  const BlogListWidget({Key? key, required this.blogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return GestureDetector(
          onTap: () {
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  blog.imageUrl,
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                blog.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                blog.id,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
