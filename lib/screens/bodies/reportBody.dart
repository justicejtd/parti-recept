import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/screens/bodies/createRecipe.dart';
import 'package:partirecept/services/authService.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/utilities/userFeedback.dart';

class ReportBody extends StatefulWidget {
  const ReportBody({
    Key? key,
    required this.commentId,
  }) : super(key: key);

  final String commentId;
  @override
  _ReportBodyState createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  var selectedValue = 'Spam or phishing';
  var details = "";

  postReport() {
    final user = new AuthService();
    final user_id = user.getAuthUser()!.uid;
    final reportData = {
      "user_id": user_id,
      "type": selectedValue,
      "details": details,
      "comment_id": firestore.doc('comment/' + widget.commentId)
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('report');
    collectionReference.add(reportData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryYellow,
        appBar: AppBar(
          title: Text('Report abuse'),
          centerTitle: true,
          backgroundColor: primaryOrange,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            //alignment: Alignment.center,
            //color: Colors.red,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            value: 'Spam or phishing',
                            groupValue: selectedValue,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Spam or phishing',
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            value: 'Contains nudity or pornography',
                            groupValue: selectedValue,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Contains nudity or pornography',
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            value: 'Harassment or threatening',
                            groupValue: selectedValue,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Harassment or threatening',
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            value: 'Child endangerment or exploitation',
                            groupValue: selectedValue,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Child endangerment or exploitation',
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            value: 'Copyright infringement',
                            groupValue: selectedValue,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Copyright infringement',
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Other',
                      style: TextThemeOswald(Colors.white).headline6,
                    ),
                    leading: Transform.scale(
                      scale: 1.2,
                      child: Radio(
                        value: 'Other',
                        groupValue: selectedValue,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 30),
                    child: Column(
                      children: [
                        Text(
                          'You can also include relevant details on the offensive content',
                          style: TextThemeOswald(Colors.white).bodyText1,
                        ),
                        TextFormField(
                            onChanged: (text) {
                              details = text;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white, filled: true),
                            minLines:
                                6, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(color: Colors.black)
                            //style: background,
                            )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primaryDarkRed,
                        ),
                        onPressed: () {
                          postReport();
                          showSnackBar(context, 'Report is submitted');
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            'Report abuse',
                            style: TextThemeOswald(Colors.white).headline5,
                          ),
                        )),
                  ),
                ]),
          ),
        ));
  }
}
