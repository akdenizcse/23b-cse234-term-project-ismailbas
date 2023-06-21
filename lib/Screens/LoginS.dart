import 'package:flutter/material.dart';
import 'package:social_media_app/Constants/Constants.dart';
import 'package:social_media_app/Services/auth_service.dart';
import 'package:social_media_app/Widgets/RoundedButton.dart';

class LoginS extends StatefulWidget {
  @override
  _LoginSState createState() => _LoginSState();
}

/** class _LoginSState extends State<LoginS> {
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Log in',
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
                hintText: 'Enter Your email',
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
                hintText: 'Enter Your password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'LOG IN',
              onBtnPressed: () async {
                bool isValid = await AuthService.login(_email, _password);
                if (isValid) {
                  Navigator.pop(context);
                } else {
                  print('login problem');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
} */
/** class _LoginSState extends State<LoginS> {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Log in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Your email',
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Your password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 40),
              RoundedButton(
                btnText: 'LOG IN',
                onBtnPressed: () async {
                  bool isValid = await AuthService.login(_email, _password);
                  if (isValid) {
                    Navigator.pop(context);
                  } else {
                    print('login problem');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

class _LoginSState extends State<LoginS> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPostAppColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Log in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Your email',
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Your password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 40),
              RoundedButton(
                btnText: 'LOG IN',
                onBtnPressed: () async {
                  bool isValid = await AuthService.login(_email, _password);
                  if (isValid) {
                    Navigator.pop(context);
                  } else {
                    print('login problem');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


