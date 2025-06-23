import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case_interface.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchBlog implements UseCase<List<BlogEntity>, BlogNoParams> {
  final BlogRepository blogRepository;

  FetchBlog({required this.blogRepository});
  @override
  Future<Either<Failures, List<BlogEntity>>> call(BlogNoParams params) {
    return blogRepository.getAllBlogs();
  }
}

class BlogNoParams {}
