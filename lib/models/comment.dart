import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String _id = "";
  String _user_id = "";
  String _comment = "";
  String _picture = "";

  Comment(this._id, this._user_id, this._comment, this._picture);

  Comment.convertDocument(QueryDocumentSnapshot commentDocument) {
    _id = commentDocument.id;
    _user_id = commentDocument['user_id'];
    _comment = commentDocument['comment'];
    _picture = commentDocument['picture'];
  }

  String get id => _id;
  String get user_id => _user_id;
  String get comment => _comment;
  String get picture => _picture;

}
