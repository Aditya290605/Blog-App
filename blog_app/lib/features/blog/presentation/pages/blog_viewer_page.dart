import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/formate_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final BlogEntity blogEntity;

  static route(BlogEntity blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blogEntity: blog));

  const BlogViewerPage({super.key, required this.blogEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogEntity.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blogEntity.posterName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${formateDate(blogEntity.updatedAt)} .  ${calculateReadingTime(blogEntity.content)} min',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        blogEntity.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Text(
                    blogEntity.content,
                    style: TextStyle(fontSize: 18, height: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
