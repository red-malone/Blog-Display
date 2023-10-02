import 'package:blogs/models/blog.dart';
import 'package:blogs/providers/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogDisplay extends StatelessWidget {
  final Blog blog;
  final bool offline;

  const BlogDisplay({super.key, required this.blog, required this.offline});

  @override
  Widget build(BuildContext context) {
    bool fav = Provider.of<BlogProvider>(context, listen: false).isfav(blog.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Provider.of<BlogProvider>(context, listen: false)
                  .toggleFavorite(blog.id);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(fav ? "Blog Removed" : "Blog Added")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          
          child: offline
              ? Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 200,
                  color: Colors.grey,
                  child: const Icon(Icons.image_not_supported_outlined),
                )
              : Card(
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
        ),
        const SizedBox(height: 16,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blog.title,
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blog.id,
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

      ),
    );
  }
}
