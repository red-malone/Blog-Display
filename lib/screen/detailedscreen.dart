import 'package:blogs/models/blog.dart';
import 'package:flutter/material.dart';

class BlogDisplay extends StatelessWidget {
  
  Blog blog;
  BlogDisplay({super.key,required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ],
      ),
      body: ,
    );
  }
}