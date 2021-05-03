import 'package:amlaky/screens/CarsDetails.dart';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:amlaky/screens/search.dart';
import 'package:amlaky/screens/settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:amlaky/apis/api_service.dart';
import 'AgentsList.dart';
import 'details_page.dart';
import 'SigninScreen.dart';
import 'package:amlaky/screens/privicy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';

class Properties extends StatefulWidget {
  bool ADsTab;
  bool AgentsTab;
  bool SearchTab;
  Properties({this.ADsTab, this.AgentsTab, this.SearchTab});
  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  bool isGrid;

  bool ADsTab = true;
  bool AgentsTab = true;
  bool SearchTab = true;
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    isGrid = true;
    getuserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool ADsTabFalse = widget.ADsTab;
    bool AgentsTabFalse = widget.AgentsTab;
    bool SearchTabFalse = widget.SearchTab;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff6f8ff),
      appBar: AppBar(
        title: Text('القائمة',
            style: TextStyle(
                color: Colors.black87, fontSize: 16, fontFamily: "Cairo")),
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        leading: ADsTabFalse == true
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                })
            : IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
        actions: [
          IconButton(
              icon: Icon(isGrid ? Icons.format_list_bulleted : Icons.grid_on),
              onPressed: () => setState(() => isGrid = !isGrid)),
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              }),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TabBar(
                    controller: _tabController,
                    unselectedLabelColor: Colors.black45,
                    labelStyle: TextStyle(fontFamily: "Cairo", fontSize: 18),
                    labelColor: Theme.of(context).accentColor,
                    tabs: [Tab(text: 'عقارات'), Tab(text: 'سيارات')]),
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Container(
                  child: isGrid ? buildEstatesGrid() : buildEstatesList(),
                ),
                Container(
                  child: isGrid ? buildCarsGrid() : buildCarsList(),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEstatesGrid() {
    return Container(
      child: FutureBuilder(
          future: fetchEstates(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                itemCount: snapShot.data.length,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                itemBuilder: (BuildContext context, int index) {
                  Map wpData = snapShot.data[index];
                  var ImgUrl =
                      wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];

                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(DetailsPage.routeName, arguments: wpData),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .33,
                                  child: CachedNetworkImage(
                                    imageUrl: ImgUrl != null ? ImgUrl : "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png",
                                    placeholder: (BuildContext context, s) =>
                                        Container(
                                      child:
                                          Image.asset("assets/img/loading.gif"),
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Container(
                                  height: 85,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          wpData["title"]["rendered"],
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color
                                                  .withOpacity(.7),
                                              fontFamily: "Cairo",
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.black45,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      wpData['_embedded'][
                                                                      'wp:term']
                                                                  [1][0]["name"]
                                                              .isNotEmpty
                                                          ? wpData['_embedded']
                                                                  ['wp:term'][1]
                                                              [0]["name"]
                                                          : " ",
                                                      style: TextStyle(
                                                          fontFamily: "Cairo",
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.home,
                                                      color: Colors.black45,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${int.parse(wpData["_Length_text_field"]) * int.parse(wpData["_width_text_field"])} sq/m',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            color: Theme.of(context).accentColor,
                            child: Text(
                              '${wpData["_diwp_text_field"]} مليون دينار',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "Cairo"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/img/no-internet.png",
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "حدث خطأ ما ! تأكد من إتصالك بالإنترنت",
                      style: TextStyle(fontFamily: "Cairo"),
                    )
                  ],
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
    );
  }

  Widget buildCarsGrid() {
    return Container(
      child: FutureBuilder(
        future: fetchCars(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.separated(
              itemCount: snapShot.data.length,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              itemBuilder: (BuildContext context, int index) {
                Map wpData = snapShot.data[index];
                var ImgUrl =
                    wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(CarsDetails.routeName, arguments: wpData),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * .33,
                            child: CachedNetworkImage(
                              imageUrl: ImgUrl != null ? ImgUrl : "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png",
                              placeholder: (BuildContext context, s) =>
                                  Container(
                                child: Image.asset("assets/img/loading.gif"),
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            height: 85,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    wpData["title"]["rendered"],
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color
                                            .withOpacity(.7),
                                        fontSize: 15,
                                        fontFamily: "Cairo"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.black45,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                wpData['_embedded']['wp:term']
                                                            [1][0]["name"]
                                                        .isNotEmpty
                                                    ? wpData['_embedded']
                                                            ['wp:term'][1][0]
                                                        ["name"]
                                                    : " ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45,
                                                    fontFamily: "Cairo"),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/color-wheel.svg",
                                                width: 18,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                wpData['_embedded']['wp:term']
                                                    [3][0]["name"],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                    fontFamily: "Cairo"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15,
                );
              },
            );
          }
          if (snapShot.hasError) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    "assets/img/no-internet.png",
                    width: MediaQuery.of(context).size.width * .6,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "حدث خطأ ما ! تأكد من إتصالك بالإنترنت",
                    style: TextStyle(fontFamily: "Cairo"),
                  )
                ],
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
        },
      ),
    );
  }

  Widget buildEstatesList() {
    return Container(
      child: FutureBuilder(
          future: fetchEstates(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                itemCount: snapShot.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
                padding: EdgeInsets.symmetric(vertical: 15),
                itemBuilder: (BuildContext context, int index) {
                  Map wpData = snapShot.data[index];
                  var ImgUrl =
                      wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(DetailsPage.routeName, arguments: wpData),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 120,
                              child: CachedNetworkImage(
                                imageUrl: ImgUrl != null ? ImgUrl : "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png",
                                placeholder: (BuildContext context, s) =>
                                    Container(
                                  child: Image.asset("assets/img/loading.gif"),
                                ),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .42,
                                    child: Text(
                                      '${wpData["title"]["rendered"]}',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color
                                              .withOpacity(.7),
                                          fontSize: 14,
                                          fontFamily: "Cairo"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black45,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              wpData['_embedded']['wp:term'][1]
                                                          [0]["name"]
                                                      .isNotEmpty
                                                  ? wpData['_embedded']
                                                      ['wp:term'][1][0]["name"]
                                                  : " ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.home,
                                              color: Colors.black45,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${int.parse(wpData["_Length_text_field"]) * int.parse(wpData["_width_text_field"])} sq/m',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${wpData["_diwp_text_field"]} مليون دينار',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 14,
                                        fontFamily: "Cairo"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/img/no-internet.png",
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "حدث خطأ ما ! تأكد من إتصالك بالإنترنت",
                      style: TextStyle(fontFamily: "Cairo"),
                    )
                  ],
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
    );
  }

  Widget buildCarsList() {
    return Container(
      child: FutureBuilder(
          future: fetchCars(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.separated(
                itemCount: snapShot.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
                padding: EdgeInsets.symmetric(vertical: 15),
                itemBuilder: (BuildContext context, int index) {
                  Map wpData = snapShot.data[index];
                  var ImgUrl =
                      wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(CarsDetails.routeName, arguments: wpData),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 120,
                              child: CachedNetworkImage(
                                imageUrl: ImgUrl != null ? ImgUrl : "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png",
                                placeholder: (BuildContext context, s) =>
                                    Container(
                                  child: Image.asset("assets/img/loading.gif"),
                                ),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .42,
                                    child: Text(
                                      '${wpData["title"]["rendered"]}',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color
                                              .withOpacity(.7),
                                          fontSize: 14,
                                          fontFamily: "Cairo"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black45,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              wpData['_embedded']['wp:term'][1]
                                                          [0]["name"] == null
                                                  ? wpData['_embedded']
                                                      ['wp:term'][1][0]["name"]
                                                  : " ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/color-wheel.svg",
                                              width: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              wpData['_embedded']['wp:term']
                                              [3][0]["name"],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${wpData["meta_box"]["_cars_text_field"]} دولار ',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontFamily: "Cairo",
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/img/no-internet.png",
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "حدث خطأ ما ! تأكد من إتصالك بالإنترنت",
                      style: TextStyle(fontFamily: "Cairo"),
                    )
                  ],
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
    );
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
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
              Navigator.pop(context);
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
                      builder: (context) => SearchScreen(
                            SearchTab: SearchTab,
                          )));
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
