import 'package:blogs/providers/dataprovider.dart';
import 'package:blogs/screen/display.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.init(appDocumentDirectory.path);
  await Hive.openBox('blogBox');
  final blogprovider =BlogProvider();
  runApp(
    ChangeNotifierProvider(
      create: (context) => blogprovider,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Blog List'),
          ),
          body:const  BlogListScreen(), 
        ),
      ),
    ),
  );
}

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);

    return Center(
      child: FutureBuilder(
        future: blogProvider.fetchBlogs(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, try to load stored blogs
            blogProvider.getStoredBlogs();
            if (blogProvider.stored.isNotEmpty) {
              return BlogListWidget(blogs: blogProvider.stored);
            } else {
              return Text('Error: ${snapshot.error}');
            }
          } else {
            return BlogListWidget(blogs: blogProvider.blogs);
          }
        },
      ),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

