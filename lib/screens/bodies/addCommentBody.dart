import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partirecept/screens/bodies/createRecipe.dart';
import 'package:partirecept/services/storage_service.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/services/authService.dart';
import 'dart:io';
import 'dart:math';
import 'package:partirecept/utilities/userFeedback.dart';

class AddCommentScreen extends StatefulWidget {
  final String recipeKey;
  const AddCommentScreen({Key? key, required this.recipeKey}) : super(key: key);

  @override
  _AddCommentScreenState createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  File? image;
  String comment = "";
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        //imageQuality: 50
      );
      if (image == null) return;

      final cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: primaryOrange,
              toolbarTitle: "PartiRecipe Cropper",
              statusBarColor: primaryDarkRed,
              backgroundColor: Colors.white));
      final imageTemporary = cropped;
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  addComment(String URL, String comment) {
    final user_id = getCurrentUserId();
    print('uid');
    print(user_id);
    final commentData = {
      "recipe_id": firestore.doc('recipe/' + widget.recipeKey),
      "user_id": user_id,
      "comment": comment,
      "picture": URL
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('comment');
    collectionReference.add(commentData);
  }

  String getCurrentUserId() {
    final user = new AuthService();
    final user_id = user.getAuthUser()!.uid;
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: secondaryYellow,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Comment about recipe'),
        centerTitle: true,
        backgroundColor: primaryOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: image != null
                    ? Image.file(
                        image!,
                        height: 350,
                        width: 350,
                        fit: BoxFit.cover,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image(
                          image: AssetImage('assets/images/no-image.jpg'),
                          height: 350,
                          width: 350,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: SizedBox(
                height: 60,
                width: 350,
                child: FlatButton.icon(
                    onPressed: pickImage,
                    icon: Icon(Icons.image_outlined, color: Colors.white),
                    label: Text('Pick Gallery',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20)),
                    color: primaryOrange,
                    shape: StadiumBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 8),
              child: Container(
                child: Expanded(
                  child: TextFormField(
                      onChanged: (text) {
                        comment = text;
                      },
                      keyboardType: TextInputType.multiline,
                      style: TextThemeOswald(Colors.white).bodyText1,
                      minLines: 2,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(500),
                          borderSide: BorderSide(color: primaryOrange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (image != null && comment != "") {
                      final String imageName = getRandomString(10);
                      await storage.uploadFile(image!, imageName);
                      final URL = await storage.getImageURL(imageName);
                      //final newComment = new Comment(1,1,comment,URL);
                      addComment(URL, comment);

                      Navigator.pop(context);
                    } else {
                      showSnackBar(
                          context, 'Please add image and enter comment');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: primaryOrange),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Post comment',
                        style: TextThemeOswald(Colors.white).headline5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
