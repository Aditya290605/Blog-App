import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocaldataSource {
  List<BlogModel> fetchBlogs();
  void uploadBlogs(List<BlogModel> blogs);
}

class BlogLocaldataSourceImpl implements BlogLocaldataSource {
  final Box box;

  BlogLocaldataSourceImpl({required this.box});

  @override
  List<BlogModel> fetchBlogs() {
    final List<BlogModel> blog = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blog.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blog;
  }

  @override
  void uploadBlogs(List<BlogModel> blogs) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
