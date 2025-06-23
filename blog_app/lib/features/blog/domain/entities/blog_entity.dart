// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogEntity {
  String title;
  String content;
  String imgUrl;
  String userid;
  String uid;
  List<String> topics;
  DateTime updatedAt;
  String? posterName;

  BlogEntity({
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.userid,
    required this.uid,
    required this.topics,
    required this.updatedAt,
    this.posterName,
  });
}
