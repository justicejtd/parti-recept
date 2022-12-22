import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      File image,
      String imageName
      ) async {
        try{
          await storage.ref('comment_images/$imageName').putFile(image);
        } on firebase_core.FirebaseException catch (e) {print(e);}
  }

  Future<String> getImageURL(String imageName) async {
    String imageURL = await storage.ref('comment_images/$imageName').getDownloadURL();
    return imageURL;
  }
}