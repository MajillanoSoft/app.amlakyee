import 'onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "Splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('seen');
      Widget _screen;
      if (seen == false || seen == null) {
        _screen = onboarding();
      } else {
        _screen = HomeScreen();
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => _screen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfbfb),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 90),
            child: Image.asset(
              "assets/img/sub_logo.png",
              width: MediaQuery.of(context).size.width * .35,
            ),
          ),
          Image.asset(
            "assets/img/splash.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
