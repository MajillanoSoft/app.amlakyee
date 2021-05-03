import 'dart:convert';
import 'dart:io';
import 'package:amlaky/screens/AddRealEstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadEstate extends StatefulWidget{
  final String userToken;
  ImageUploadEstate({this.userToken});
  @override
  State<StatefulWidget> createState() {
    return _ImageUpload();
  }
}

class _ImageUpload extends State<ImageUploadEstate>{
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  File file;
  var imageName;
  var imgformat;
  Future chooseEstateImage() async {
    final _faturedimagefile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = File(_faturedimagefile.path);
      String base64 = base64Encode(file.readAsBytesSync());
      String imgpath = file.path.split("/").last;
      imgformat = imgpath.split(".").last;
    });
  }

  Future uploadEstateImage() async {
    var headers = {
      'Authorization': 'Bearer ${widget.userToken}',
      'Content-Disposition': 'form-data; filename="featured_image_estate.jpg"'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://amlakyee.com/wp-json/wp/v2/media'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      final Map resestateimage = jsonDecode(response.body);
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
          'تم رفع الصورة بنجاح',
          style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
        ),
        backgroundColor: Colors.green,
      ));
      int esImgId = resestateimage["id"];
      Future.delayed(const Duration(milliseconds: 2500), () {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AddRealEstate(
              esImgId: esImgId,
              userToken: widget.userToken,
            )
        ));
      });
    }
    else {
      final Map resimage = jsonDecode(response.body);
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
          'حدث خطأ ما!',
          style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
        ),
        backgroundColor: Colors.red,
      ));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("رفع صورة للإعلان", style: TextStyle(
            fontFamily: "Cairo"
        ),),
        backgroundColor: Color(0xFFd3142e),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //content alignment to center
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: file == null? Image.asset("assets/placeholder.png") : Image.file(file) //load image from file
              )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton.icon(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: (){
                      chooseEstateImage(); // call choose image function
                    },
                    icon:Icon(Icons.folder_open),
                    label: Text("أختر صورة الإعلان", style: TextStyle(
                        fontFamily: "Cairo"
                    ),),
                    color: Color(0xFFffffff),
                    colorBrightness: Brightness.light,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton.icon(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: (){
                      uploadEstateImage(); // call choose image function
                    },
                    icon:Icon(Icons.upload_rounded),
                    label: Text("رفع صورة الإعلان", style: TextStyle(
                        fontFamily: "Cairo"
                    ),),
                    color: Color(0xFFd3142e),
                    colorBrightness: Brightness.dark,
                  ),
                ),
              ],
            ),
          ),

        ],),
    );
  }
}