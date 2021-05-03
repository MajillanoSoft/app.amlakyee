import 'package:amlaky/apis/api_service.dart';
import 'package:amlaky/screens/privicy_policy.dart';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:amlaky/screens/properties.dart';
import 'package:amlaky/screens/search.dart';
import 'package:amlaky/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SigninScreen.dart';
import 'homePage.dart';

class AgentsList extends StatefulWidget {
  bool AgentsTab;
  bool ADsTab;
  bool SearchTab;
  AgentsList({this.AgentsTab, this.ADsTab, this.SearchTab});
  @override
  _AgentsListState createState() => _AgentsListState();
}

class _AgentsListState extends State<AgentsList> {
  bool AgentsTab = true;
  bool ADsTab = true;
  bool SearchTab = true;
  String location = "";
  String niceName;
  String Token;
  int Id;
  String Email;
  String Avatar;
  bool logined;

  Future getuserLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logined = prefs.getBool("loginsucsess");
      niceName = prefs.getString("loginname");
      Token = prefs.getString("logintoken");
      Email = prefs.getString("loginemail");
      Avatar = prefs.getString("loginavatar");
      Id = prefs.getInt("loginid");
    });
  }

  Future<List> fetchAllUsers(String location) async {
    final response = await http.get(
        "$Webaite_URL/wp-json/wp/v2/users?filter[meta_key]=land&filter[meta_value]=$location&per_page=100",
        headers: {'Accept': 'application/json'});
    var convtoJson = jsonDecode(response.body);
    return convtoJson;
  }

  @override
  void initState() {
    getuserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool AgentsTabFalse = widget.AgentsTab;
    bool ADsTabFalse = widget.ADsTab;
    bool SearchTabFalse = widget.SearchTab;
    return Scaffold(
      backgroundColor: Color(0xfff6f8ff),
      appBar: AppBar(
        title: Text(
          "الوكلاء",
          style: TextStyle(fontFamily: "Cairo", color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              })
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "الكل",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15),
                //   child: FlatButton(
                //     shape: new RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(30.0),
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         location = "أربيل";
                //       });
                //     },
                //     color: Colors.white,
                //     child: Text(
                //       "أربيل",
                //       style: TextStyle(
                //           fontFamily: "Cairo",
                //           fontWeight: FontWeight.w300,
                //           fontSize: 13),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "الانبار";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "الانبار",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "البصرة";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "البصرة",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15),
                //   child: FlatButton(
                //     shape: new RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(30.0),
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         location = "السليمانية";
                //       });
                //     },
                //     color: Colors.white,
                //     child: Text(
                //       "السليمانية",
                //       style: TextStyle(
                //           fontFamily: "Cairo",
                //           fontWeight: FontWeight.w300,
                //           fontSize: 13),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "القادسية";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "القادسية",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "المثنى";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "المثنى",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "النجف الأشرف";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "النجف الأشرف",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "بابل";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "بابل",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "بغداد";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "بغداد",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "حلبجة";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "حلبجة",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15),
                //   child: FlatButton(
                //     shape: new RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(30.0),
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         location = "دهوك";
                //       });
                //     },
                //     color: Colors.white,
                //     child: Text(
                //       "دهوك",
                //       style: TextStyle(
                //           fontFamily: "Cairo",
                //           fontWeight: FontWeight.w300,
                //           fontSize: 13),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "ديالى";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "ديالى",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "ذي قار";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "ذي قار",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "صلاح الدين";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "صلاح الدين",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "كركوك";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "كركوك",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "ميسان";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "ميسان",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "نينوى";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "نينوى",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      setState(() {
                        location = "واسط";
                      });
                    },
                    color: Colors.white,
                    child: Text(
                      "واسط",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 225,
            child: FutureBuilder(
                future: fetchAllUsers(location),
                builder: (context, userssnapshot) {
                  if (userssnapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: userssnapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map usersData = userssnapshot.data[index];
                          var AvatarUrl = usersData["avatar_urls"]["48"];
                          return ConstrainedBox(
                              constraints: new BoxConstraints(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white,
                                ),
                                child: Transform.translate(
                                  offset: Offset(0, -30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                        child: Image.network(
                                          AvatarUrl,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          usersData["land"],
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Cairo",
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        usersData["name"],
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Cairo",
                                            fontSize: 18),
                                      ),
                                      usersData["job"] != ""
                                          ? Text(
                                        usersData["job"],
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "Cairo",
                                            fontSize: 15),
                                      )
                                          : Container(),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Text(
                                            usersData["description"],
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontFamily: "Cairo",
                                                fontSize: 14),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          )),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          usersData["user_phone"] != ""
                                              ? Text(usersData["user_phone"])
                                              : Container(),
                                          usersData["user_phone"] != "" ||
                                              usersData["user_phone_2"] !=
                                                  ""
                                              ? Text(" - ")
                                              : Container(),
                                          usersData["user_phone_2"] != ""
                                              ? Text(usersData["user_phone_2"])
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              "assets/icons/facebook.svg",
                                              width: 25,
                                            ),
                                            onPressed: () async {
                                              var url =
                                                  "${usersData['user_fb_link']}";
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'حدث خطأ ما! يرجى المحاولة لاحقا $url';
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              "assets/icons/twitter.svg",
                                              width: 25,
                                            ),
                                            onPressed: () async {
                                              var url =
                                                  "${usersData['user_tw_link']}";
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'حدث خطأ ما! يرجى المحاولة لاحقا $url';
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: SvgPicture.asset(
                                              "assets/icons/instagram.svg",
                                              width: 25,
                                            ),
                                            onPressed: () async {
                                              var url =
                                                  "${usersData['user_insta_link']}";
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'حدث خطأ ما! يرجى المحاولة لاحقا $url';
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff6f8ff),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(30))),
                                              child: Text(
                                                "مكتب الوكيل",
                                                style: TextStyle(
                                                    fontFamily: "cairo",
                                                    fontSize: 13),
                                              )),
                                          onTap: () async {
                                            var url =
                                                '${usersData['location_link']}';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Loading(
                            indicator: BallBeatIndicator(),
                            size: 50.0,
                            color: Theme.of(context).accentColor)),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(context) {
    return Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Padding(
                padding: EdgeInsets.only(right: 45),
                child: Image.asset(
                  "assets/img/sub_logo.png",
                  width: MediaQuery.of(context).size.width * .22,
                )),
            SizedBox(
              height: 55,
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/home-2.svg",
                    width: 25,
                  ),
                  title: Text(
                    "الرئيسية",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Properties()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/pro.svg",
                    width: 30,
                  ),
                  title: Text(
                    "العقارات و السيارات",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/search.svg",
                    width: 25,
                  ),
                  title: Text(
                    "البحث",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/group.svg",
                    width: 25,
                  ),
                  title: Text(
                    "الوكلاء",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Settings()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/information.svg",
                    width: 25,
                  ),
                  title: Text(
                    "عن أملاكي",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivecyPolicy()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/privacy-policy.svg",
                    width: 25,
                  ),
                  title: Text(
                    "سياسة الخصوصية",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => logined == true ? profileScreen(
                        nicename: niceName,
                        jsonid: Id,
                        userToken: Token,
                        userEmail: Email,
                        userAvatar: Avatar,
                      ) : SigninScreen()));
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/login.svg",
                    width: 25,
                  ),
                  title: Text(
                    logined == true ? "حسابي" : "تسجيل الدخول للوكيل" ,
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
