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
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'imageurl': imgUrl,
      'userid': userid,
      'id': uid,
      'topic': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      title: map['title'],
      content: map['content'],
      imgUrl: map['imageurl'],
      userid: map['userid'],
      uid: map['id'],
      topics: List<String>.from((map['topic'])),
      updatedAt:
          map['updated_at'] == null
              ? DateTime.now()
              : DateTime.parse(map['updated_at']),
    );
  }

  BlogModel copyWith({
    String? title,
    String? content,
    String? imgUrl,
    String? userid,
    String? uid,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      title: title ?? this.title,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      userid: userid ?? this.userid,
      uid: uid ?? this.uid,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
