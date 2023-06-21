import 'package:flutter/material.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Models/Activity.dart';
import 'package:social_media_app/Models/UserModel.dart';
import 'package:social_media_app/Services/DatabaseServices.dart';

class NotificationsS extends StatefulWidget {
  final String currentUserId;

  const NotificationsS({Key? key, required this.currentUserId}) : super(key: key);
  @override
  _NotificationsSState createState() => _NotificationsSState();
}

class _NotificationsSState extends State<NotificationsS> {
  List<Activity> _activities = [];

  setupActivities() async {
    List<Activity> activities =
    await DatabaseServices.getActivities(widget.currentUserId);
    if (mounted) {
      setState(() {
        _activities = activities;
      });
    }
  }

  buildActivity(Activity activity) {
    return FutureBuilder(
        future: usersRef.doc(activity.fromUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          } else {
            UserModel user = UserModel.fromDoc(snapshot.data);
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: user.profilePicture.isEmpty
                        ? const AssetImage('assets/placeholder.png')
                        : NetworkImage(user.profilePicture) as ImageProvider<Object>?,
                  ),
                  title: activity.follow == true
                      ? Text('${user.name} follows you')
                      : Text('${user.name} liked your post'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: KPostAppColor,
                    thickness: 1,
                  ),
                )
              ],
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setupActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupActivities(),
          child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = _activities[index];
                return buildActivity(activity);
              }),
        ));
  }
}