import 'package:amlaky/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var regesterKey = GlobalKey<FormState>();
  var userName = TextEditingController();
  var passwordField = TextEditingController();

   void _SignIn() async {
    var url = 'https://amlakyee.com/wp-json/jwt-auth/v1/token';
    var body = jsonEncode({'username': userName.text, 'password': passwordField.text});
    await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    ).then((http.Response response) async{
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final Map res = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loginsucsess', true);
        prefs.setInt("loginid", res["user_id"]);
        prefs.setString("logintoken", res["token"]);
        prefs.setString("loginemail", res["user_email"]);
        prefs.setString("loginname", res["user_nicename"]);
        prefs.setString("loginavatar", res["avatar"]);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'تم تسجيل الدخول بنجاح',
            style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
          ),
          backgroundColor: Colors.green,
        ));
        Future.delayed(const Duration(milliseconds: 1500), () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String niceName = prefs.getString("loginname");
        String Token = prefs.getString("logintoken");
        String Email = prefs.getString("loginemail");
        int Id = prefs.getInt("loginid");
        String Avatar = prefs.getString("loginavatar");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return profileScreen(
                  jsonid: Id,
                  nicename: niceName,
                  userEmail: Email,
                  userToken: Token,
                  userAvatar: Avatar,
              );
            }),
          );
        });
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'حدث خطأ ما!',
            style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: regesterKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height* .25,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .3,
                //height: MediaQuery.of(context).size.width * .7,
                alignment: Alignment.center,
                child: Image.network("https://amlakyee.com/wp-content/themes/amlaky/assets/images/logo-icon.png",
                    width: MediaQuery.of(context).size.width * .7),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 25.0, right: 25.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: userName,
                        decoration: InputDecoration(
                            labelText: 'أسم المستخدم',
                            labelStyle: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontSize: 14),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFd3142e)))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: passwordField,
                        decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontSize: 14),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFd3142e)))),
                        obscureText: true,
                      ),
                      SizedBox(height: 45.0),
                      InkWell(
                        onTap: () {
                          _SignIn();
                        },
                        child: Container(
                          height: 50.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(50.0),
                            shadowColor: Color(0xFFd3142e),
                            color: Color(0xFFd3142e),
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'تسجيل دخول',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  )),
              SizedBox(height: 45.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 55),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'جميع الحقوق وملكية تطبيق أملاكي لشركة عصر النجاح',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Cairo', fontSize: 14, color: Colors.black26),
                ),
              )
            ],
          ),
        ));
  }

}
