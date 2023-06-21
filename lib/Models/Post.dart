import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String authorId;
  String text;
  String image;
  Timestamp timestamp;
  int likes;
  int reposts;

  Post(
      {required this.id,
        required this.authorId,
        required this.text,
        required this.image,
        required this.timestamp,
        required this.likes,
        required this.reposts});

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      image: doc['image'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      reposts: doc['reposts'],
    );
  }
}