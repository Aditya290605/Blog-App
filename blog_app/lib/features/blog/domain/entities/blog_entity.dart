class BlogEntity {
  String title;
  String content;
  String imgUrl;
  String userid;
  String uid;
  List<String> topics;
  DateTime updatedAt;

  BlogEntity({
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.userid,
    required this.uid,
    required this.topics,
    required this.updatedAt,
  });
}
