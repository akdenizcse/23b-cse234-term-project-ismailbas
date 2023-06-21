import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

const Color KPostAppColor = Color(0xff13b3c5);

final _fireStore = FirebaseFirestore.instance;

final usersRef = _fireStore.collection('users');

final feedRefs = _fireStore.collection('feeds');

final followersRef = _fireStore.collection('followers');

final followingRef = _fireStore.collection('following');

final storageRef = FirebaseStorage.instance.ref();

final postsRef = _fireStore.collection('posts');

final likesRef = _fireStore.collection('likes');

final activitiesRef = _fireStore.collection('activities');