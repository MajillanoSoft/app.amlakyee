import 'package:amlaky/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:amlaky/apis/api_service.dart';
import 'package:html/parser.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RsSearchPage extends SearchDelegate {
  RsSearchPage()
      : super(searchFieldLabel: "أكتب عنوان العقار الذي تبحث عنه ...");
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Scaffold(
          backgroundColor: Color(0xfff6f8ff),
          body: Center(
            child: Text(
              "ستظهر نتائج بحثك هنا مباشرة ..",
              style: TextStyle(fontFamily: "Cairo"),
            ),
          ));
    } else {
      return FutureBuilder(
        future: fetchReal_EstatesSearch(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Map resultaData = snapshot.data[index];
                var imgUrl = resultaData["_embedded"]["wp:featuredmedia"][0]
                    ["source_url"];
                return InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .33,
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                              placeholder: (BuildContext context, s) =>
                                  Container(
                                child: Image.asset("assets/img/loading.gif"),
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            resultaData['title']['rendered'],
                            style: TextStyle(
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            parse(resultaData["excerpt"]["rendered"].toString())
                                .documentElement
                                .text,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Cairo", fontSize: 15, height: 1.9),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                        DetailsPage.routeName,
                        arguments: resultaData));
              },
            );
          } else {
            return Center(
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Loading(
                        indicator: BallBeatIndicator(),
                        size: 50.0,
                        color: Theme.of(context).accentColor)));
          }
        },
      );
    }
  }
}
