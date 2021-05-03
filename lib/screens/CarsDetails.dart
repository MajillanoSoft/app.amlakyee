import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class CarsDetails extends StatelessWidget {
  const CarsDetails({Key key}) : super(key: key);
  static const routeName = "CarsDetails";

  @override
  Widget build(BuildContext context) {
    Map wpData = ModalRoute.of(context).settings.arguments as Map;
    String VideoUrl = wpData["meta_box"]["cars_youtube_link"] == "" ? "https://www.youtube.com/watch?v=rRl6pHlvRho" : wpData["meta_box"]["cars_youtube_link"];
    var videoID = YoutubePlayer.convertUrlToId(VideoUrl);
     YoutubePlayerController _controller = YoutubePlayerController(
       initialVideoId: videoID,
      // flags: YoutubePlayerFlags(
      //   autoPlay: false,
      //   loop: false,
      // ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .6,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: wpData["_embedded"]["wp:featuredmedia"][0]
                    ["source_url"] != null ? wpData["_embedded"]["wp:featuredmedia"][0]["source_url"] :
                    "https://amlakyee.com/wp-content/uploads/2021/02/amlaky-icon.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .6,
                    placeholder: (context, url) => Container(
                      color: Colors.black12,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(.6),
                              Colors.black.withOpacity(.5),
                              Colors.black.withOpacity(.4),
                              Colors.transparent
                            ],
                        ),
                      ),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        toolbarHeight: 50,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        title: Text(
                          "التفاصيل",
                          style: TextStyle(fontSize: 16, fontFamily: "Cairo"),
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(.7),
                                  Colors.black.withOpacity(.6),
                                  Colors.black.withOpacity(.5),
                                  Colors.transparent
                                ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(wpData["title"]["rendered"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Cairo",
                                      fontSize: 18)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white.withOpacity(.6),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    wpData['_embedded']['wp:term'][1][0]
                                        ["name"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: "Cairo"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Spacer(),
                                  Text(
                                    "رقم الإعلان : " + wpData['id'].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Cairo"),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: wpData["_embedded"]["author"][0]
                              ["avatar_urls"]["48"],
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wpData["author_meta"]["user_nicename"],
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd MMMM, yyyy', 'ar')
                              .format(DateTime.parse(wpData["date"]))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.black54,
                              fontSize: 14,
                              height: 1.2),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      wpData["_cars_text_field"].toString() + " دولار ",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffc60001)),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              color: Colors.black26,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "نوع السيارة",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][2][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "اللون",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][3][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "المسافة المقطوعة",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              wpData["_distance_text_field"] != ""
                                  ? "${wpData["_distance_text_field"]} /"
                                  : "",
                              style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                            ),
                            SizedBox(width: 8,),
                            Text(
                              wpData["meta_box"]["_distance_select_fieldselect"],
                              style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black26,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "الموديل",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][7][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "نوع الوقود",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][5][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "نوع وارد",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][4][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black26,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "نوع ناقل الحركة",
                    style: TextStyle(fontFamily: "Cairo", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffc60001)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    wpData['_embedded']['wp:term'][6][0]["name"],
                    style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black26,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السيارة حرة أم مطلوبة؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][8][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السنوية بأسم البائع؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][9][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السيارة مرقمة أم لا؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][10][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السيارة تحمل ضرر؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][11][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السيارة مكفولة؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['_embedded']['wp:term'][12][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "مكان صاحب السيارة؟",
                          style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xffc60001)),
                        ),
                        Text(
                          wpData['carsAgentLocation'].isEmpty ||
                                  wpData['carsAgentLocation'] == null ||
                                  wpData['carsAgentLocation'] == 0
                              ? ""
                              : wpData['_embedded']['wp:term'][13][0]["name"],
                          style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " رقم هاتف صاحب السيارة ",
                    style: TextStyle(fontFamily: "Cairo", fontSize: 16, fontWeight: FontWeight.bold,
                        color: Color(0xffc60001)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                      onTap: () async {
                        var phone_number = wpData["_carsAgentPhone_text_field"];
                        await launch("tel:${phone_number}");
                      },
                      child: Text(
                        wpData['_carsAgentPhone_text_field'],
                        style: TextStyle(fontFamily: "Cairo", fontSize: 14),
                      )),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "التفاصيل :",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    parse(wpData["content"]["rendered"].toString())
                        .documentElement
                        .text,
                    style: TextStyle(
                        fontFamily: "Cairo", fontSize: 15, height: 1.9),
                  ),
                ),

                wpData["meta_box"]["cars_youtube_link"] == null || wpData["meta_box"]["cars_youtube_link"] == "" || wpData["meta_box"]["cars_youtube_link"].isEmpty ?
                SizedBox() :
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "فيديو",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                wpData["meta_box"]["cars_youtube_link"] == null || wpData["meta_box"]["cars_youtube_link"] == "" || wpData["meta_box"]["cars_youtube_link"].isEmpty ?
                SizedBox():
                Container(
                  height: MediaQuery.of(context).size.width > 700
                      ? MediaQuery.of(context).size.height * .45
                      : 240,
                  child: YoutubePlayer(
                  width: MediaQuery.of(context).size.width,
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
                )
                ,
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: wpData["meta_box"]["cars_gallery"].isEmpty
                      ? Text("")
                      : Text(
                          "صور أخرى :",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                          child: wpData["meta_box"]["cars_gallery"].length >= 1
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][0]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                          child: wpData["meta_box"]["cars_gallery"].length >= 2
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][1]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                          child: wpData["meta_box"]["cars_gallery"].length >= 3
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][2]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 4
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][3]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 5
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][4]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 6
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][5]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 7
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][6]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 8
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][7]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 9
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][8]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 10
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][9]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 11
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][10]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      Container(
                          child: wpData["meta_box"]["cars_gallery"].length >= 12
                              ? Image.network(
                                  wpData["meta_box"]["cars_gallery"][11]
                                      ["full_url"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Container()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Colors.white10),
          height: 50,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.share,
                    color: Colors.black45,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Share.share('مشاركة المنشور : ' + wpData["link"]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
