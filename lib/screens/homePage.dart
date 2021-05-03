import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:amlaky/screens/search.dart';
import 'package:amlaky/screens/articles.dart';

import 'AgentsList.dart';
import 'properties.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "Home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
    _pages = [Home(), Properties(), SearchScreen(), AgentsList()];

    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _backpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "هل تريد الخروج من التطبيق؟",
                style: TextStyle(fontSize: 18, fontFamily: "Cairo"),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    "لا",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text(
                    "نعم",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                  onPressed: () => exit(0),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backpressed,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff010B17),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 24,
                    color: _selectedIndex == 0
                        ? Color(0xFFd3142e)
                        : Color(0xffffffff),
                  ),
                  title: Text(
                    "الرئيسية",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 12,
                        color: _selectedIndex == 0
                            ? Color(0xFFd3142e)
                            : Colors.white),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/pro.svg',
                    width: 30,
                    color: _selectedIndex == 1
                        ? Color(0xFFd3142e)
                        : Color(0xffffffff),
                  ),
                  title: Text(
                    "الإعلانات",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 12,
                        color: _selectedIndex == 1
                            ? Color(0xFFd3142e)
                            : Colors.white),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 24,
                    color: _selectedIndex == 2
                        ? Color(0xFFd3142e)
                        : Color(0xffffffff),
                  ),
                  title: Text(
                    "البحث",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 12,
                        color: _selectedIndex == 2
                            ? Color(0xFFd3142e)
                            : Colors.white),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/group.svg',
                    width: 30,
                    color: _selectedIndex == 3
                        ? Color(0xFFd3142e)
                        : Color(0xffffffff),
                  ),
                  title: Text(
                    "الوكلاء",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 12,
                        color: _selectedIndex == 3
                            ? Color(0xFFd3142e)
                            : Colors.white),
                  )),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.black,
            onTap: (selectedIndex) {
              setState(() {
                _selectedIndex = selectedIndex;
                _pageController.jumpToPage(selectedIndex);
              });
            },
            elevation: 7,
            type: BottomNavigationBarType.fixed),
      ),
    );
  }
}
