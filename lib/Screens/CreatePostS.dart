import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' ;
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Models/Post.dart';
import 'package:social_media_app/Services/DatabaseServices.dart';
import 'package:social_media_app/Services/StorageService.dart';
import 'package:social_media_app/Widgets/RoundedButton.dart';

class CreatePostS extends StatefulWidget {
  final String currentUserId;

  const CreatePostS({Key? key, required this.currentUserId}) : super(key: key);
  @override
  _CreatePostSState createState() => _CreatePostSState();
}

class _CreatePostSState extends State<CreatePostS> {
  String _postText = '';
  File? _pickedImage;
  bool _loading = false;

  handleImageFromGallery() async {
    try {
     final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);
        setState(() {
          _pickedImage = imageFile;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: KPostAppColor,
        centerTitle: true,
        title: Text(
          'Create a Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              maxLength: 280,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'Write your Thoughts',
              ),
              onChanged: (value) {
                _postText = value;
              },
            ),
            SizedBox(height: 10),
            _pickedImage == null
                ? SizedBox.shrink()
                : Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: KPostAppColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_pickedImage!),
                      )),
                ),
                SizedBox(height: 20),
              ],
            ),
            GestureDetector(
              onTap: handleImageFromGallery,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: KPostAppColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: KPostAppColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundedButton(
              btnText: 'Share',
              onBtnPressed: () async {
                setState(() {
                  _loading = true;
                });
                if (_postText != null && _postText.isNotEmpty) {
                  String image;
                  if (_pickedImage == null) {
                    image = '';
                  } else {
                    image = await StorageService.uploadPostPicture(_pickedImage!);
                  }
                  Post post = Post(
                    text: _postText,
                    image: image,
                    authorId: widget.currentUserId,
                    likes: 0,
                    reposts: 0,
                    timestamp: Timestamp.fromDate(
                      DateTime.now(),
                    ), id: '',
                  );
                  DatabaseServices.createPost(post);
                  Navigator.pop(context);
                }
                setState(() {
                  _loading = false;
                });
              },
            ),
            SizedBox(height: 20),
            _loading ? CircularProgressIndicator() : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}