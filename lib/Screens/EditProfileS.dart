import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Models/UserModel.dart';
import 'package:social_media_app/Services/DatabaseServices.dart';
import 'package:social_media_app/Services/StorageService.dart';

class EditProfileS extends StatefulWidget {
  final UserModel user;

  const EditProfileS({Key? key, required this.user}) : super(key: key);
  @override
  _EditProfileSState createState() => _EditProfileSState();
}

class _EditProfileSState extends State<EditProfileS> {
   String _name = '';
   String _bio = '';
   File? _profileImage;
   File? _coverImage;
   String _imagePickedType = '';
   final _formKey = GlobalKey<FormState>();
   bool _isLoading = false;

  displayCoverImage() {
    if (_coverImage == null) {
      if (widget.user.coverImage.isNotEmpty) {
        return NetworkImage(widget.user.coverImage);
      }
    } else {
      return FileImage(_coverImage!);
    }
  }

  displayProfileImage() {
    if (_profileImage == null) {
      if (widget.user.profilePicture.isEmpty) {
        return AssetImage('assets/placeholder.png');
      } else {
        return NetworkImage(widget.user.profilePicture);
      }
    } else {
      return FileImage(_profileImage!);
    }
  }
   /** saveProfile() async {
     _formKey.currentState?.save();
     if (_formKey.currentState!.validate() && !_isLoading) {
       setState(() {
         _isLoading = true;
       });
       String profilePictureUrl = '';
       String coverPictureUrl = '';
       if (_profileImage == null) {
         profilePictureUrl = widget.user.profilePicture;
       } else {
         profilePictureUrl = await StorageService.uploadProfilePicture('', _profileImage!);
       }
       if (_coverImage == null) {
         coverPictureUrl = widget.user.coverImage;
       } else {
         coverPictureUrl = await StorageService.uploadCoverPicture('', _coverImage!);
       }
       UserModel user = UserModel(
         id: widget.user.id,
         name: _name,
         profilePicture: profilePictureUrl,
         email: '',
         bio: _bio,
         coverImage: coverPictureUrl,
       );

       DatabaseServices.updateUserData(user);
       Navigator.pop(context);
     }
   } */

   Future<void> saveProfile() async {
     _formKey.currentState?.save();
     if (_formKey.currentState!.validate() && !_isLoading) {
       setState(() {
         _isLoading = true;
       });

       String profilePictureUrl = widget.user.profilePicture;
       String coverPictureUrl = widget.user.coverImage;

       if (_profileImage != null) {
         profilePictureUrl = await StorageService.uploadProfilePicture(profilePictureUrl, _profileImage!,);
       }

       if (_coverImage != null) {
         coverPictureUrl = await StorageService.uploadCoverPicture(coverPictureUrl, _coverImage!,);
       }

       UserModel user = UserModel(
         id: widget.user.id,
         name: _name,
         profilePicture: profilePictureUrl,
         email: '',
         bio: _bio,
         coverImage: coverPictureUrl,
       );

       DatabaseServices.updateUserData(user);
       Navigator.pop(context);
     }
   }



   handleImageFromGallery() async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);
      if (_imagePickedType == 'profile') {
        setState(() {
          _profileImage = imageFile;
        });
      } else if (_imagePickedType == 'cover') {
        setState(() {
          _coverImage = imageFile;
        });
      }
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          GestureDetector(
            onTap: () {
              _imagePickedType = 'cover';
              handleImageFromGallery();
            },
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: KPostAppColor,
                    image: _coverImage == null && widget.user.coverImage.isEmpty
                        ? null
                        : DecorationImage(
                      fit: BoxFit.cover,
                      image: displayCoverImage(),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  color: Colors.black54,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 70,
                        color: Colors.white,
                      ),
                      Text(
                        'Change Cover Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _imagePickedType = 'profile';
                        handleImageFromGallery();
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: displayProfileImage(),
                          ),
                          const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.black54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Change Profile Photo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: saveProfile,
                      child: Container(
                        width: 100,
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: KPostAppColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          initialValue: _name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: KPostAppColor),
                          ),
                          validator: (input) => input!.trim().length < 2
                              ? 'please enter valid name'
                              : null,
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          initialValue: _bio,
                          decoration: const InputDecoration(
                            labelText: 'Bio',
                            labelStyle: TextStyle(color: KPostAppColor),
                          ),
                          onSaved: (value) {
                            _bio = value!;
                          },
                        ),
                        const SizedBox(height: 30),
                        _isLoading
                            ? const CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation(KPostAppColor),
                        )
                            : const SizedBox.shrink()
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}