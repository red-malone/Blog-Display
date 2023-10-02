import 'package:blogs/models/blog.dart';
import 'package:blogs/screen/detailedscreen.dart';
import 'package:flutter/material.dart';

class BlogListWidget extends StatelessWidget {
  final List<Blog> blogs;
  final bool offline;

  const BlogListWidget({Key? key, required this.blogs, required this.offline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return blogs.isEmpty
        ? const Center(
            child: Text('No blogs found!'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blog = blogs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          BlogDisplay(blog: blog, offline: offline)));
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: offline
                            ? Container(
                                height: 200,
                                color: Colors.grey,
                                child: const Icon(
                                    Icons.image_not_supported_outlined),
                              )
                            : Image.network(
                                blog.imageUrl,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                      ListTile(
                        title: Text(
                          blog.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          blog.id,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
