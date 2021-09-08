import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String id;
  String description;
  String title;
  Timestamp date;
  String userId;

  NoteModel({
    this.id,
    this.description,
    this.title,
    this.date,
    this.userId,
  });

  factory NoteModel.fromJson(DocumentSnapshot snapshot) {
    return NoteModel(
        id: snapshot.id,
        description: snapshot['description'],
        title: snapshot['title'],
        date: snapshot['date'],
        userId: snapshot['userId']);
  }
}
