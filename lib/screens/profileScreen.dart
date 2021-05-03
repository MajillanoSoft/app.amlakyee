import 'dart:async';

import 'package:amlaky/screens/AddCars.dart';
import 'package:amlaky/screens/SigninScreen.dart';
import 'package:amlaky/screens/UploadMediaCar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:amlaky/apis/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'CarsDetails.dart';
import 'UploadMediaEstate.dart';
import 'details_page.dart';

class profileScreen extends StatefulWidget {
  final int jsonid;
// final String avatarUrl;
  final String nicename;
  final String userEmail;
  final String userToken;
  final String userAvatar;

  profileScreen({Key key, this.jsonid, this.nicename, this.userEmail, this.userToken, this.userAvatar})
      : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  bool isGrid;

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("loginsucsess");
    prefs.remove("loginid");
    prefs.remove("logintoken");
    prefs.remove("loginemail");
    prefs.remove("loginname");
    prefs.remove("loginavatar");
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'تم تسجيل الخروج بنجاح',
        style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
      ),
      backgroundColor: Colors.green,
    ));
    Future.delayed(const Duration(milliseconds: 1500), () async{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return SigninScreen();
        }),
      );
    });
  }



  Future<List> fetchCarsbyAuthor() async {
    final response = await http.get(
        '$Webaite_URL/wp-json/wp/v2/cars?_embed&author[]=${widget.jsonid}',
        headers: {'Accept': 'application/json'});
    var toJson = jsonDecode(response.body);
    return toJson;
  }

  Future<List> fetchEstatesbyAuthor() async {
    final response = await http.get(
        '$Webaite_URL/wp-json/wp/v2/real_estate?_embed&author[]=${widget.jsonid}',
        headers: {'Accept': 'application/json'});
    var toJson = jsonDecode(response.body);
    return toJson;
  }

  Future fetchuser() async {
    var response = await http.get(
        'https://amlakyee.com/wp-json/wp/v2/users/${widget.jsonid}',
        headers: {'Accept': 'application/json'});
    var toJson = jsonDecode(response.body);
    return toJson;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    isGrid = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff6f8ff),
      appBar: AppBar(
        title: Text('الملف الشخصي',
            style: TextStyle(
                color: Colors.black87, fontSize: 16, fontFamily: "Cairo")),
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(isGrid ? Icons.format_list_bulleted : Icons.grid_on),
              onPressed: () => setState(() => isGrid = !isGrid)),
          IconButton(
              icon: SvgPicture.asset("assets/icons/logout.svg"),
              onPressed: () {
                logout();
              }
    ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(widget.avatarUrl.toString()),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              // widget.avatarUrl
              child: CachedNetworkImage(
                imageUrl:
                    widget.userAvatar == null ? "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png" : widget.userAvatar,
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Text(
              widget.nicename,
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.userEmail,
              style: TextStyle(fontFamily: "Cairo", fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "رصيد حسابك",
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " : ",
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Transform.translate(
                  offset: Offset(-5,3),
                  child: SizedBox(
                    width: 140,
                    height: 35,
                    child: FutureBuilder(
                        future: fetchuser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int indx) {
                                return Text(snapshot.data["user_balance"] == null ? "0" : snapshot.data["user_balance"].toString() + " " + "دينار عراقي", style: TextStyle(
                                  fontFamily: "Cairo"
                                ),);
                              },
                            );
                          }else {
                            return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: Loading(
                                      indicator: BallBeatIndicator(),
                                      size: 25.0,
                                      color: Theme.of(context).accentColor)),
                            );
                          }
                        })
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                    tabs: [Tab(text: 'عقاراتي'), Tab(text: 'سياراتي')]),
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Stack(
                  children: [
                    ButtonTheme(
                        buttonColor: Color(0xFFd3142e),
                        minWidth: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                            future: fetchuser(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (BuildContext context, int indx) {
                                    int finpay = snapshot.data["user_balance"] == null ? 0 : snapshot.data["user_balance"];
                                    return finpay < 25000 ? SizedBox() : Container(
                                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .39),
                                      alignment: Alignment.bottomCenter,
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        child: Text("أضافة عقار", style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),),
                                        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageUploadEstate(userToken: widget.userToken,))),
                                      ),
                                    );
                                  },
                                );
                              }
                              else {
                                return SizedBox();
                              }
                            })
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .375,
                      child: isGrid ? buildEstatesGrid() : buildEstatesList(),
                    ),

                  ],
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ButtonTheme(
                          buttonColor: Color(0xFFd3142e),
                          minWidth: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                              future: fetchuser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context, int indx) {
                                      int finpay = snapshot.data["user_balance"] == null ? 0 : snapshot.data["user_balance"];
                                      return finpay < 15000 ? SizedBox() :
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .38),
                                        child: RaisedButton(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text("أضافة سيارة", style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),),
                                          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageUpload(userToken: widget.userToken,))),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return SizedBox();
                                }
                              })
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .375,
                      child: isGrid ? buildCarsGrid() : buildCarsList(),
                    ),

                  ],
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
          future: fetchEstatesbyAuthor(),
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
                                  MediaQuery.of(context).size.height * .25,
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
                              '${wpData["meta_box"]["_diwp_text_field"]} مليون دينار',
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
        future: fetchCarsbyAuthor(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.separated(
              itemCount: snapShot.data.length,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              itemBuilder: (BuildContext context, int index) {
                Map wpData = snapShot.data[index];
                var ImgUrl =
                wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];
                return Stack(
                  children: [
                    GestureDetector(
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
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: ImgUrl == null ? "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png" : ImgUrl,
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
                    ),
                    Positioned(
                      right: 10,
                      top: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          '${wpData["meta_box"]["_cars_text_field"]} \$',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "Cairo"),
                        ),
                      ),
                    ),
                  ],
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
          future: fetchEstatesbyAuthor(),
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
                                imageUrl: ImgUrl == null ? "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png" : ImgUrl,
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
                                              '${wpData["_sq_text_field"]}  sq/m',
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
          future: fetchCarsbyAuthor(),
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
                                imageUrl: ImgUrl == null ? "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png" : ImgUrl,
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
                                            SvgPicture.asset(
                                              "assets/icons/color-wheel.svg",
                                              width: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${wpData['_embedded']['wp:term'][3][0]["name"]}',
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
                                    '${wpData["_cars_text_field"]}',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
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

}
