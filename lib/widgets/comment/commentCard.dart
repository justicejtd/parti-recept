import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/comment.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';

import 'package:partirecept/screens/bodies/reportBody.dart';

class commentCard extends StatelessWidget {
  const commentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryOrange,
      margin: EdgeInsets.all(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              comment.picture,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(comment.comment,
                  style: TextThemeOswald(Colors.white).bodyText1)),
          Text('Posted by Username'),
          Row(children: [
            FlatButton(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportBody(commentId: comment.id),
                    ));
              },
              color: Colors.black45,
              child: Icon(Icons.report_problem_outlined,
                  color: Colors.white, size: 30),
            ),
          ]),
        ],
      ),
    );
  }
}
