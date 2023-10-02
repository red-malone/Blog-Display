import 'package:blogs/models/blog.dart';
import 'package:blogs/models/favourites_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogProvider extends ChangeNotifier {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  List<Blog> blogs = [];
  List<Blog> stored = [];
  List<Blog> favourites = [];

  Future<void> fetchBlogs(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['blogs'];
        blogs = data.map((item) => Blog.fromJson(item)).toList();
        final blogBox = await Hive.openBox('blogBox');
        await blogBox.put('blogs', blogs);
      } else {
        throw Exception('Failed to load blogs!');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  Future<void> getStoredBlogs() async {
    final blogBox = await Hive.openBox('blogBox');
    stored = blogBox.get('blogs');
  }

  final FavoriteManager favoriteManager = FavoriteManager();


  void toggleFavorite(String blogId) {
    if (favoriteManager.isFavorite(blogId)) {
      favoriteManager.removeFromFavorites(blogId);
    } else {
      favoriteManager.addToFavorites(blogId);
    }


    notifyListeners();
  }

  bool isfav(String blogid) {
    if (favoriteManager.isFavorite(blogid)) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> getFavoriteBlogs() async {
    favourites =
        blogs.where((blog) => favoriteManager.isFavorite(blog.id)).toList();
  }
}
