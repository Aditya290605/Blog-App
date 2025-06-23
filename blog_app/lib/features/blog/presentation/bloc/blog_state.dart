part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogSuccess extends BlogState {
  final List<BlogEntity>? blog;

  BlogSuccess(this.blog);
}

class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}
