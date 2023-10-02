import 'package:blogs/providers/dataprovider.dart';
import 'package:blogs/screen/display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final blogprovider =BlogProvider();
  runApp(
    ChangeNotifierProvider(
      create: (context) => blogprovider,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Blog List'),
          ),
          body: BlogListScreen(), 
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
            return Text('Error: ${snapshot.error}');
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

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

