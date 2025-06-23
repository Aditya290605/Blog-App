// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUpload _blogUpload;
  final FetchBlog _fetchBlog;

  BlogBloc({required BlogUpload blogUpload, required FetchBlog fetchBlog})
    : _blogUpload = blogUpload,
      _fetchBlog = fetchBlog,

      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlog>((event, emit) async {
      final res = await _blogUpload.call(
        BlogParams(
          event.title,
          event.content,
          event.image,
          event.userid,
          event.topics,
        ),
      );

      res.fold(
        (l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogSuccess(List.empty())),
      );
    });

    on<GetAllBlogs>((event, emit) async {
      final res = await _fetchBlog.call(BlogNoParams());
      res.fold(
        (l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogSuccess(r)),
      );
    });
  }
}
