import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failures, BlogEntity>> uploadBlog({
    required String title,
    required String content,
    required File image,
    required String userid,
    required List<String> topics,
  });

  Future<Either<Failures, List<BlogEntity>>> getAllBlogs();
}
