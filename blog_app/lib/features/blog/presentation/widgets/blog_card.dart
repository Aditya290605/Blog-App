import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Chip(
                                side: BorderSide(color: AppPallete.borderColor),
                                color: WidgetStatePropertyAll(
                                  AppPallete.backgroundColor,
                                ),
                                label: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                blog.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
