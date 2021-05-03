import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagesScreen extends StatelessWidget {
  ImagesScreen(Map wpData, {Key key}) : super(key : key);
  static const routeName = "Image Gallery";

  @override
  Widget build(BuildContext context) {
    Map wpData = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Hero(
          tag: 'imageHero',
          child: CachedNetworkImage(
            imageUrl:
              wpData["meta_box"]["cars_gallery"][0]["sizes"]["thumbnail"]["url"],
            width: 300,
          )),
    );
  }
}
