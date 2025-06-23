import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';

import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDataSource;

  BlogRepositoryImplementation({required this.blogRemoteDataSource});

  @override
  Future<Either<Failures, BlogModel>> uploadBlog({
    required String title,
    required String content,
    required File image,
    required String userid,
    required List<String> topics,
  }) async {
    BlogModel blog = BlogModel(
      title: title,
      content: content,
      imgUrl: '',
      userid: userid,
      uid: Uuid().v1(),
      topics: topics,
      updatedAt: DateTime.now(),
    );

    try {
      final res = await blogRemoteDataSource.uploadImage(
        image: image,
        blog: blog,
      );

      blog = blog.copyWith(imgUrl: res);

      final updatedBlog = await blogRemoteDataSource.uploadBlog(blog);
      return right(updatedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<BlogEntity>>> getAllBlogs() async {
    try {
      final res = await blogRemoteDataSource.getAllBlogs();
      return right(res);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
