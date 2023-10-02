import 'package:blogs/providers/dataprovider.dart';
import 'package:blogs/screen/display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    return FutureBuilder(
        future: blogProvider.getFavoriteBlogs(),
        builder: (context, snapshot) {
          return BlogListWidget(
            blogs: blogProvider.favourites, 
            offline: false);
        });
  }
}
