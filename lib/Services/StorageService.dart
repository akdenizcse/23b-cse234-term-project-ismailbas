import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadProfilePicture(String url, File imageFile) async {
    String uniquePhotoId = Uuid().v4();
    File compimage = await compressImage(uniquePhotoId, XFile(imageFile.path))
        .then((value) => File(value!.path));

    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      uniquePhotoId = exp.firstMatch(url)?.group(1) ?? uniquePhotoId;
    }
    UploadTask uploadTask = storageRef
        .child('images/users/userProfile_$uniquePhotoId.jpg')
        .putFile(compimage);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadCoverPicture(String url, File imageFile) async {
    String uniquePhotoId = Uuid().v4();
    File compimage = await compressImage(uniquePhotoId, XFile(imageFile.path))
        .then((value) => File(value!.path));

    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userCover_(.*).jpg');
      uniquePhotoId = exp.firstMatch(url)?.group(1) ?? uniquePhotoId;
    }
    UploadTask uploadTask = storageRef
        .child('images/users/userCover_$uniquePhotoId.jpg')
        .putFile(compimage);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadPostPicture(File imageFile) async {
    String uniquePhotoId = Uuid().v4();
    File compimage = await compressImage(uniquePhotoId, XFile(imageFile.path))
        .then((value) => File(value!.path));

    UploadTask uploadTask = storageRef
        .child('images/posts/post_$uniquePhotoId.jpg')
        .putFile(compimage);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<XFile?> compressImage(String photoId, XFile image) async {
    final tempDirection = await getTemporaryDirectory();
    final path = tempDirection.path;
    File compressedImage = File(image.path);
    return await FlutterImageCompress.compressAndGetFile(
      compressedImage.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
  }
}
