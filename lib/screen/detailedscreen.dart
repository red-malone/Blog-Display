import 'package:blogs/blog.dart';
import 'package:flutter/material.dart';

class BlogDisplay extends StatelessWidget {
  final Blog blog;
  const BlogDisplay({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(blog.title),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      blog.imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 1,
                    ),
                  ),
                ),
                Text(blog.title),
                Text(blog.id),
              ],
            ),
          ),
        ));
  }
}
