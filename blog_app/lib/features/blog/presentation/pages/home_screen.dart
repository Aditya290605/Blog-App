import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AddNewBlogPage().route());
        },
        backgroundColor: AppPallete.gradient1,
        child: Icon(Icons.add),
      ),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
