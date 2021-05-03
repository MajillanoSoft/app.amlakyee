import 'package:flutter/material.dart';
import 'package:amlaky/models/onBoarding-models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';

class onboarding extends StatefulWidget {
  static const routeName = "onBoarding";
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Color(0xFFd3142e) : Colors.grey[350],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        body: Container(
          height: MediaQuery.of(context).size.height - 120,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[3].getImageAssetPath(),
                title: mySLides[3].getTitle(),
                desc: mySLides[3].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 3
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        controller.animateToPage(2,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "تخطي",
                        style: TextStyle(
                            color: Color(0xFFd3142e),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Cairo"),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        print("this is slideIndex: $slideIndex");
                        controller.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "التالي",
                        style: TextStyle(
                            color: Color(0xFFa7a7a7),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Cairo"),
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(bottom: 115, left: 50, right: 50),
                    decoration: BoxDecoration(
                        color: Color(0xFFd3142e),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            _updateSeen();
                            return HomeScreen();
                          }),
                        );
                      },
                      child: Text(
                        "بدأ التطبيق",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Cairo"),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 90),
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          "جميع الحقوق وملكية التطبيق لشركة عصر النجاح",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

void _updateSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('seen', true);
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFFd3142e),
              fontFamily: "Cairo",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Text(desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    height: 1.9,
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontFamily: "Cairo")),
          )
        ],
      ),
    );
  }
}
