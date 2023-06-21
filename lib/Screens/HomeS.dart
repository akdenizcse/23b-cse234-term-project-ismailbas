import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Models/Post.dart';
import 'package:social_media_app/Models/UserModel.dart';
import 'package:social_media_app/Screens/CreatePostS.dart';
import 'package:social_media_app/Services/DatabaseServices.dart';
import 'package:social_media_app/Widgets/PostContainer.dart';

class HomeS extends StatefulWidget {
  final String currentUserId;

  const HomeS({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  List _followingPosts = [];
  bool _loading = false;

  Widget buildPosts(Post post, UserModel author) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: PostContainer(
        post: post,
        author: author,
        currentUserId: widget.currentUserId,
      ),
    );
  }

  List<Widget> showFollowingPosts(String currentUserId) {
    List<Widget> followingPostsList = [];
    for (Post post in _followingPosts) {
      followingPostsList.add(
          FutureBuilder(
          future: usersRef.doc(post.authorId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel author = UserModel.fromDoc(snapshot.data!);
              return buildPosts(post, author);
            } else {
              return const SizedBox.shrink();
            }
          }));
    }
    return followingPostsList;
  }

  Future<void> setupFollowingPosts() async {
    setState(() {
      _loading = true;
    });
    List followingPosts = await DatabaseServices.getHomePosts(widget.currentUserId);
    if (mounted) {
      setState(() {
        _followingPosts = followingPosts;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupFollowingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Image.asset('assets/tweet.png'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePostS(
                      currentUserId: widget.currentUserId,
                    )));
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          leading: Container(
            height: 40,
            child: Image.asset('assets/logo.png'),
          ),
          title: const Text(
            'Home',
            style: TextStyle(
              color: KPostAppColor,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupFollowingPosts(),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              _loading ? const LinearProgressIndicator() : SizedBox.shrink(),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  Column(
                    children: _followingPosts.isEmpty && !_loading == false?
                         [ const SizedBox(height: 5),
                            const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                             'there are no new posts',
                            style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ]
                  : showFollowingPosts(widget.currentUserId),

                  ),
                ],
              )
            ],
          ),
        ));
  }
}