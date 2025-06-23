part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class UploadBlog extends BlogEvent {
  final String title;
  final String content;
  final File image;
  final String userid;
  final List<String> topics;

  UploadBlog(this.title, this.content, this.image, this.userid, this.topics);
}

class GetAllBlogs extends BlogEvent {}
