import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({required File image, required BlogModel blog});
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final res =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(res.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.uid, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.uid);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final List res = await supabaseClient
          .from('blogs')
          .select('*, profiles(name)');

      return res
          .map(
            (item) => BlogModel.fromJson(
              item,
            ).copyWith(posterName: item['profiles']?['name'] ?? ''),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
