import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Screens/FeedS.dart';
import 'package:social_media_app/Screens/WelcomeS.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

 class MyApp extends StatelessWidget {
  //const MyApp({super.key});

   Widget getScreenId() {
     return StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (BuildContext context, snapshot) {
           if (snapshot.hasData) {
             return FeedS(currentUserId: snapshot.data!.uid);
           } else {
             return WelcomeS();
           }
         });
   }


   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData.light(),
       home: getScreenId(),
     );
   }
 }
