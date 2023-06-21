import 'package:flutter/material.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Services/auth_service.dart';
import 'package:social_media_app/Widgets/RoundedButton.dart';

class RegistrationS extends StatefulWidget {
  @override
  _RegistrationSState createState() => _RegistrationSState();
}

class _RegistrationSState extends State<RegistrationS> {
  String _email = '';
  String _password = '';
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPostAppColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'Create an Account',
              onBtnPressed: () async {
                bool isValid =
                    await AuthService.signUp(_name, _email, _password);
                if (isValid) {
                  Navigator.pop(context);
                } else {
                  print('Something Wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
