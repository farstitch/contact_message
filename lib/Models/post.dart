import 'package:contact_message/Models/user.dart';

class Post {
  final String title;
  final String content;
  final String picture;
  final User user; //final Map user; //-> id, name //sebelum import file user.dart

  Post(
      {required this.title,
      required this.content,
      required this.picture,
      required this.user});

  //agar data dimasukkan tidak berulang
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json['title'],
        content: json['content'],
        picture: json['picture'],
        user: User.fromJson(json['user'])); // user: json['user']); //->sebelum import file user.dart
  }
}
