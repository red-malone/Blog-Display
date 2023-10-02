import 'package:blogs/models/blog.dart';
import 'package:blogs/providers/dataprovider.dart';
import 'package:blogs/screen/display.dart';
import 'package:blogs/screen/favourites.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox('blogBox');
  final blogprovider = BlogProvider();
  runApp(
    ChangeNotifierProvider(
      create: (context) => blogprovider,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TabScreen(),
      ),
    ),
  );
}


class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Blog List'),
          ),
          body:_currentIndex==0? const BlogListScreen():const FavouriteScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
            ],
          )
        );
  }
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
            final connectivityResult = snapshot.data as ConnectivityResult;
            bool isOnline = connectivityResult != ConnectivityResult.none;

            if (!isOnline) {
              blogProvider.getStoredBlogs();
              if (blogProvider.stored.isNotEmpty) {
                return BlogListWidget(
                  blogs: blogProvider.stored,
                  offline: true,
                );
              } else {
                return const Center(
                  child: Text('No blogs found!'),
                );
              }
            }

            return Text('Error: ${snapshot.error}');
          } else {
            return BlogListWidget(
              blogs: blogProvider.blogs,
              offline: false,
            );
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

