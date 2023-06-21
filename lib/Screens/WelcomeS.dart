import 'package:flutter/material.dart';
import 'package:social_media_app/Screens/LoginS.dart';
import 'package:social_media_app/Screens/RegistrationS.dart';
import 'package:social_media_app/Widgets/RoundedButton.dart';

class WelcomeS extends StatefulWidget {
  @override
  _WelcomeSState createState() => _WelcomeSState();
}

/** class _WelcomeSState extends State<WelcomeS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'See what’s happening in the world right now',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  RoundedButton(
                      btnText: 'LOG IN',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginS()));
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationS()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
} */
/** class _WelcomeSState extends State<WelcomeS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 200,
                      width: 200,
                    ),
                    Text(
                      'See what’s happening in the world right now',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RoundedButton(
                      btnText: 'LOG IN',
                      onBtnPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginS()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () async {
                       await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationS()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} */
class _WelcomeSState extends State<WelcomeS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 200,
                      width: 200,
                    ),
                    const Text(
                      'See what’s happening in the world right now',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RoundedButton(
                      btnText: 'LOG IN',
                      onBtnPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginS()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationS()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



