import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case_interface.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';

import 'package:fpdart/fpdart.dart';

class BlogUpload implements UseCase<BlogEntity, BlogParams> {
  final BlogRepository blogRepository;

  BlogUpload({required this.blogRepository});
  @override
  Future<Either<Failures, BlogEntity>> call(BlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      image: params.image,
      userid: params.userid,
      topics: params.topics,
    );
  }
}

class BlogParams {
  final String title;
  final String content;
  final File image;
  final String userid;

  final List<String> topics;

  BlogParams(this.title, this.content, this.image, this.userid, this.topics);
}
