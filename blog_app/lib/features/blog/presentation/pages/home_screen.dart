import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  route() => MaterialPageRoute(builder: (context) => HomeScreen());
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BlogEntity> blogs = [];

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogs());
  }

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
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            debugPrint(state.error);
          }

          if (state is BlogSuccess) {
            blogs = state.blog!;
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, BlogViewerPage.route(blogs[index]));
                },
                child: BlogCard(
                  blog: blogs[index],
                  color:
                      index % 3 == 0
                          ? AppPallete.gradient1
                          : index % 3 == 1
                          ? AppPallete.gradient2
                          : AppPallete.gradient3,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
