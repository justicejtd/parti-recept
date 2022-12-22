import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/models/comment.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/widgets/Animation/loadingSpinner.dart';
import 'package:partirecept/widgets/comment/commentCard.dart';

import 'addCommentBody.dart';

class CommentBody extends StatelessWidget {
  final String recipeKey;

  CommentBody({Key? key, required this.recipeKey}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    final recipeDocRef =
        FirebaseFirestore.instance.collection('recipe').doc(recipeKey);
    final Stream<QuerySnapshot> _collectionCommentStream = FirebaseFirestore
        .instance
        .collection('comment')
        .where("recipe_id", isEqualTo: recipeDocRef)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _collectionCommentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length == 0) {
            print(snapshot.data!.docs.length);
            return Scaffold(
              backgroundColor: secondaryYellow,
              appBar: AppBar(
                title: Text('Comments'),
                centerTitle: true,
                backgroundColor: primaryOrange,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryOrange,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCommentScreen(recipeKey: recipeKey)));
                },
                child: Icon(Icons.add),
              ),
              body: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No comments',
                    style: TextThemeOswald(Colors.white).headline4,
                  )),
            );
          }

          if (snapshot.hasData == false) {
            return Scaffold(
              backgroundColor: secondaryYellow,
              appBar: AppBar(
                title: Text('Comments'),
                centerTitle: true,
                backgroundColor: primaryOrange,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryOrange,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCommentScreen(recipeKey: recipeKey)));
                },
                child: Icon(Icons.add),
              ),
              body: Text('No comments'),
            );
          }
          return Scaffold(
              backgroundColor: secondaryYellow,
              appBar: AppBar(
                title: Text('Comments'),
                centerTitle: true,
                backgroundColor: primaryOrange,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryOrange,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCommentScreen(recipeKey: recipeKey)));
                },
                child: Icon(Icons.add),
              ),
              body: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final recipeDocument = snapshot.data!.docs[index];
                  final comment = Comment.convertDocument(recipeDocument);
                  return commentCard(comment: comment);
                },
              ));
        });
  }
}
