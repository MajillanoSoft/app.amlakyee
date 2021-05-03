import 'package:amlaky/screens/privicy_policy.dart';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:amlaky/screens/properties.dart';
import 'package:amlaky/screens/search.dart';
import 'package:amlaky/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'AgentsList.dart';
import 'SigninScreen.dart';
import 'dart:async';

class Home extends StatefulWidget {
  bool AgentsTab = true;
  bool ADsTab = true;
  bool SearchTab = true;
  Home({this.ADsTab, this.AgentsTab, this.SearchTab});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool AgentsTab = true;
  bool ADsTab = true;
  bool SearchTab = true;

  AnimationController _animationController;
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

  final List<dynamic> SliderItems = [
    "assets/img/slide-1.jpg",
    "assets/img/slide-2.jpg",
    "assets/img/slide-3.jpg",
    "assets/img/slide-4.jpg",
  ];

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 550), vsync: this);
    Timer(Duration(milliseconds: 550), () => _animationController.forward());
    getuserLogin();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool AgentsTabFalse = widget.AgentsTab;
    bool ADsTabFalse = widget.ADsTab;
    bool SearchTabFalse = widget.SearchTab;
    return Scaffold(
        backgroundColor: Color(0xfff6f8ff),
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('الرئيسية',
              style: TextStyle(
                  color: Colors.black87, fontSize: 16, fontFamily: "Cairo")),
          iconTheme: IconThemeData(color: Colors.black45),
          centerTitle: true,
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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ListView(
          children: <Widget>[
            CarouselSlider.builder(
              itemCount: 4,
              options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      SliderItems[index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                    ),
                  ),
                );
              },
            ),
            FirstItem(
              animationController: _animationController,
            ),
            SecondItem(
              animationController: _animationController,
            ),
            ThirdItem(
              animationController: _animationController,
            ),
            FourthItem(
              animationController: _animationController,
            ),
            Bottom(
              animationController: _animationController,
            ),
          ],
        ));
  }

  ///Widgets
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
               Navigator.pop(context);
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
              setState(() {
                ADsTab == false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Properties(
                            ADsTab: ADsTab,
                          )));
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
              setState(() {
                SearchTab == false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(SearchTab: SearchTab)));
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
              setState(() {
                AgentsTab == false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgentsList(AgentsTab: AgentsTab)));
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

class FirstItem extends StatelessWidget {
  final AnimationController animationController;
  FirstItem({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 2),
                end: Offset(0, 0),
              ).animate(animationController),
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 13),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFd3142e),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        width: 55,
                        height: 55,
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(left: 13),
                        child: SvgPicture.asset("assets/icons/browser.svg",
                            width: 25, color: Colors.white),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          'ابحث عن العقار او السيارة التي تريدها في صفحة الإعلانات',
                          style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondItem extends StatelessWidget {
  final AnimationController animationController;

  SecondItem({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 2),
                end: Offset(0, 0),
              ).animate(animationController),
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 13),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF385C7B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        width: 55,
                        height: 55,
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(left: 13),
                        child: SvgPicture.asset("assets/icons/info.svg",
                            width: 25, color: Colors.white),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          'معرفة العقار أو السيارة التابعة لمحافظتك',
                          style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdItem extends StatelessWidget {
  final AnimationController animationController;
  ThirdItem({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 8),
                end: Offset(0, 0),
              ).animate(animationController),
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 13),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFd3142e),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        width: 55,
                        height: 55,
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(left: 13),
                        child: SvgPicture.asset("assets/icons/call.svg",
                            width: 25, color: Colors.white),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          'تواصل مع الوكيل بشأن العقار او السيارة التي ترغب بشرائها من خلال الضغط فقط على رقم الوكيل',
                          style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthItem extends StatelessWidget {
  final AnimationController animationController;
  FourthItem({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 20),
                end: Offset(0, 0),
              ).animate(animationController),
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 13),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF385C7B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        width: 55,
                        height: 55,
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(left: 13),
                        child: SvgPicture.asset("assets/icons/done.svg",
                            width: 25, color: Colors.white),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          'اذا كنت ترغب بأضافة عقار او سيارة اتصل بالوكيل التابع لمحافظتك',
                          style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  final AnimationController animationController;

  Bottom({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-22, 0),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
          opacity: animationController,
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Properties()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40, right: 20, left: 20),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xFFd3142e),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'إنتقال إلى الإعلانات',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Cairo",
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline5
                              .color,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xFFd3142e),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'من نحن',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Cairo",
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline5
                              .color,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          )),
    );
  }
}
