import 'dart:convert';
import 'package:amlaky/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:amlaky/apis/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ByCarsPrice extends StatefulWidget {
  final int priceval;
  final String name;
  ByCarsPrice(this.priceval, this.name, {Key key}) : super(key: key);
  @override
  _ByCarsPriceState createState() => _ByCarsPriceState();
}

class _ByCarsPriceState extends State<ByCarsPrice> {


  Future<List> fetchcarsbyprice() async {
    final response =
    await http.get(
        "$Webaite_URL/wp-json/wp/v2/cars?filter[meta_key]=_cars_text_field&filter[meta_compare]=<&filter[meta_value]=${widget.priceval.toString()}?_fields=link,title,featured_media,_links,_embedded&_embed&per_page=100", headers: {'Accept': 'application/json'});
    var convetoJson = jsonDecode(response.body);
    return convetoJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebeef3),
      appBar: AppBar(
        centerTitle: true,
        leading: Text(""),
        title: Text(widget.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Cairo')),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
            future: fetchcarsbyprice(),
            builder: (context, carspricesnapshot) {
              if (carspricesnapshot.hasData) {
                if(carspricesnapshot.data.length == 0) {
                  return Container(height: MediaQuery.of(context).size.height * .75,
                      child: Center( child: Text("لا يوجد محتوى في هذا التصنيف!", style: TextStyle(fontFamily: "Cairo"),)));
                }
                return ListView.separated(
                  itemCount: carspricesnapshot.data.length,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  itemBuilder: (BuildContext context, int index) {
                    Map wpData = carspricesnapshot.data[index];
                    var ImgUrl =
                    wpData["_embedded"]["wp:featuredmedia"][0]["source_url"];
                    return GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(DetailsPage.routeName, arguments: wpData),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                  width: 125,
                                  height: 145,
                                  margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: ImgUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (BuildContext context, s) => Container(
                                        child: Image.asset("assets/img/loading.gif"),
                                      ),
                                    ),
                                  )
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .5,
                                padding: EdgeInsets.only(top: 12, left: 10, right: 0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wpData["title"]["rendered"],
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color
                                              .withOpacity(.7),
                                          fontFamily: "Cairo",
                                          fontSize: 15),
                                    ),
                                    SizedBox(height: 8,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFd3142e).withOpacity(.7),
                                              borderRadius: BorderRadius.circular(30)),
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                          child: Text(
                                            wpData['_embedded']['wp:term'][2][0]["name"],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Cairo",),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, 5, 4, 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.timer,
                                                    color: Colors.black45,
                                                    size: 14.0,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(DateFormat('dd MMMM, yyyy', 'ar')
                                                      .format(DateTime.parse(wpData["date"]))
                                                      .toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Cairo",
                                                        fontSize: 14,
                                                        color: Colors.black54
                                                    ),),

                                                  Text(
                                                    wpData["_cars_text_field"] != "" ? " ${wpData["_cars_text_field"]} دولار "
                                                        : "" ,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Cairo",
                                                      color: Color(0xFFd3142e),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
              if (carspricesnapshot.hasError) {
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
      ),
    );
  }
}
