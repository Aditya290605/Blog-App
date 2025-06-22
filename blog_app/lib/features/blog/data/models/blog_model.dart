import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.title,
    required super.content,
    required super.imgUrl,
    required super.userid,
    required super.uid,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'imageurl': imgUrl,
      'userid': userid,
      'uid': uid,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      title: map['title'] as String,
      content: map['content'] as String,
      imgUrl: map['imagurl'] as String,
      userid: map['userid'] as String,
      uid: map['uid'] as String,
      topics: List<String>.from((map['topics'] as List<String>)),
      updatedAt:
          map['updated_at'] == null
              ? DateTime.now()
              : DateTime.parse(map['updated_at']),
    );
  }
}
