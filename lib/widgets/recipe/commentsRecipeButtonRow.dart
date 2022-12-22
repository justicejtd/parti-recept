import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/screens/bodies/commentBody.dart';

class CommentsRecipeButtonRow extends StatelessWidget {
  final String recipeKey;

  const CommentsRecipeButtonRow({Key? key, required this.recipeKey}) : super(key: key);
  static const double padding = 15;
  static const double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(padding, padding, padding, padding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentBody(recipeKey: recipeKey)));
                        },
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Icon(Icons.comment_rounded, color: Colors.white, size: iconSize,),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Text(
                              'View Comments',
                              style: TextThemeOswald(Colors.white).headline5,
                          ),
                        ),
                      color: primaryDarkRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
