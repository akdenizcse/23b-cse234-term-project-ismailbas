import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Screens/CreatePostS.dart';
import 'package:social_media_app/Screens/HomeS.dart';
import 'package:social_media_app/Screens/NotificationsS.dart';
import 'package:social_media_app/Screens/ProfileS.dart';
import 'package:social_media_app/Screens/SearchS.dart';

class FeedS extends StatefulWidget {
  final String currentUserId;

  const FeedS({Key? key, required this.currentUserId}) : super(key: key);
  @override
  _FeedSState createState() => _FeedSState();
}

class _FeedSState extends State<FeedS> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeS(
          currentUserId: widget.currentUserId,
        ),
        SearchS(
          currentUserId: widget.currentUserId,
        ),
        NotificationsS(
          currentUserId: widget.currentUserId,
        ),
        ProfileS(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: KPostAppColor,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}