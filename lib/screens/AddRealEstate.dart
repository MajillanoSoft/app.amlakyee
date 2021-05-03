import 'dart:convert';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddRealEstate extends StatefulWidget {
  final String userToken;
  final int esImgId;
  AddRealEstate({this.userToken, this.esImgId});
  @override
  _AddRealEstateState createState() => _AddRealEstateState();
}

class _AddRealEstateState extends State<AddRealEstate> {
  var addEstateKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var EstateTile = TextEditingController();
  var EstateDesc = TextEditingController();
  var EstateWidth = TextEditingController();
  var EstateLength = TextEditingController();
  var EstatePrice = TextEditingController();
  var EstateAgentNumber = TextEditingController();
  var EstateVideo = TextEditingController();

  var estateTypeValue;
  List estateTypeItems = [
    ["سكني", 57],
    ["عرصة", 58],
    ["مكان تجاري", 59],
  ];

  var LayersValue;
  List LayersItems = [
    ["1", 492],
    ["2", 493],
    ["3", 494],
    ["4", 495],
    ["5", 496],
    ["6", 497],
    ["7", 498],
    ["8", 499],
    ["9", 500],
    ["10", 501],
    ["11", 502],
    ["12", 503],
    ["13", 504],
    ["14", 505],
    ["15", 506],
    ["16", 507],
    ["17", 508],
    ["18", 509],
    ["19", 510],
    ["20", 511],
  ];

  var estateLocationValue;
  List estateLocationItems = [
    ["أربيل", 20],
    ["أنبار", 19],
    ["بصرة", 23],
    ["سليمانية", 35],
    ["القادسية", 33],
    ["مثنى", 30],
    ["نجف", 31],
    ["بابل", 21],
    ["بغداد", 22],
    ["حلبجة", 37],
    ["دهوك", 26],
    ["ديالى", 25],
    ["ذي قار", 24],
    ["صلاح الدين", 34],
    ["كربلاء", 27],
    ["كركوك", 28],
    ["ميسان", 29],
    ["نينوى", 32],
    ["واسط", 36],
  ];

  var landTypeValue;
  List landTypeItems = [
    ["طابو زراعي", 61],
    ["طابو صرف", 60],
    ["عقد زراعي", 62],
    ["مكاتبة", 63],
  ];

  var land_shapeValue;
  List land_shapeItems = [
    ["عدل", 64],
    ["قيناص", 65],
  ];

  var building_materialsValue;
  List building_materialsItems = [
    ["أعمدة كونكريت", 67],
    ["بلوك", 68],
    ["طابوق", 66],
    ["غيره", 69],
  ];

  var building_dateValue;
  List building_dateItems = [
    ["2021", 544],
    ["2020", 120],
    ["2019", 119],
    ["2018", 118],
    ["2017", 117],
    ["2016", 116],
    ["2015", 115],
    ["2014", 114],
    ["2013", 113],
    ["2012", 112],
    ["2011", 111],
    ["2010", 110],
    ["2009", 109],
    ["2008", 108],
    ["2007", 107],
    ["2006", 106],
    ["2005", 105],
    ["2004", 104],
    ["2003", 103],
    ["2002", 102],
    ["2001", 101],
    ["2000", 100],
    ["1999", 99],
    ["1998", 98],
    ["1997", 97],
    ["1996", 96],
    ["1995", 95],
    ["1994", 94],
    ["1993", 93],
    ["1992", 92],
    ["1991", 91],
    ["1990", 90],
    ["1989", 89],
    ["1988", 88],
    ["1987", 87],
    ["1986", 86],
    ["1985", 85],
    ["1984", 84],
    ["1983", 83],
    ["1982", 82],
    ["1981", 81],
    ["1980", 80],
    ["1979", 79],
    ["1978", 78],
    ["1977", 77],
    ["1976", 76],
    ["1975", 75],
    ["1974", 74],
    ["1973", 73],
    ["1972", 72],
    ["1971", 71],
    ["1970", 70],
  ];

  var ad_typeValue;
  List ad_typeItems = [
    ["بيع", 490],
    ["أيجار", 491],
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFd3142e),
        title: Text(
          "أضافة عقار",
          style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40, right: 20, left: 20),
        child: ListView(
          children: [
            Form(
              autovalidate: true,
              key: addEstateKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: EstateTile,
                    decoration: InputDecoration(
                        labelText: 'عنوان العقار',
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFd3142e)))),
                    validator: (value) {
                      if(value.length < 1){
                        return 'هذا الحقل إجباري';
                      }else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: EstateDesc,
                    decoration: InputDecoration(
                        labelText: 'تفاصيل العقار',
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFd3142e)))),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: EstateLength,
                          decoration: InputDecoration(
                              labelText: 'الطول',
                              labelStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                  fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFd3142e)))),
                          validator: (value) {
                            if(value.length < 1){
                              return 'هذا الحقل إجباري';
                            }else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: EstateWidth,
                          decoration: InputDecoration(
                              labelText: 'العرض',
                              labelStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                  fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFd3142e)))),
                          validator: (value) {
                            if(value.length < 1){
                              return 'هذا الحقل إجباري';
                            }else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: EstatePrice,
                    decoration: InputDecoration(
                        labelText: 'السعر',
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFd3142e)))),
                    validator: (value) {
                      if(value.length < 1){
                        return 'هذا الحقل إجباري';
                      }else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    controller: EstateAgentNumber,
                    decoration: InputDecoration(
                        labelText: 'رقم هاتف الوكيل',
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFd3142e)))),
                    validator: (value) {
                      if(value.length < 11){
                        return 'هذا الحقل إجباري';
                      }else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر المحافظة",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: estateLocationValue,
                      onChanged: (newestateLocationValue) {
                        setState(() {
                          estateLocationValue = newestateLocationValue;
                        });
                      },
                      items: estateLocationItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem[0].toString(),
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر نوع العقار",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: estateTypeValue,
                      onChanged: (newestateTypeValue) {
                        setState(() {
                          estateTypeValue = newestateTypeValue;
                        });
                      },
                      items: estateTypeItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر عدد الطوابق",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: LayersValue,
                      onChanged: (newLayersValue) {
                        setState(() {
                          LayersValue = newLayersValue;
                        });
                      },
                      items: LayersItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر نوع الأرض",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: landTypeValue,
                      onChanged: (newlandTypeValue) {
                        setState(() {
                          landTypeValue = newlandTypeValue;
                        });
                      },
                      items: landTypeItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر شكل الأرض",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: land_shapeValue,
                      onChanged: (newland_shapeValue) {
                        setState(() {
                          land_shapeValue = newland_shapeValue;
                        });
                      },
                      items: land_shapeItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر نوع البناء	",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: building_materialsValue,
                      onChanged: (newbuilding_materialsValue) {
                        setState(() {
                          building_materialsValue = newbuilding_materialsValue;
                        });
                      },
                      items: building_materialsItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر سنة البناء",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: building_dateValue,
                      onChanged: (newbuilding_dateValue) {
                        setState(() {
                          building_dateValue = newbuilding_dateValue;
                        });
                      },
                      items: building_dateItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                      validator: (value) => value == null
                          ? 'هذا الإختيار إجباري!' : null,
                      hint: Text("أختر نوع الإعلان",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: ad_typeValue,
                      onChanged: (newad_typeValue) {
                        setState(() {
                          ad_typeValue = newad_typeValue;
                        });
                      },
                      items: ad_typeItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem[0].toString(),
                              style: TextStyle(fontFamily: "Cairo")),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    controller: EstateVideo,
                    decoration: InputDecoration(
                        labelText: 'رابط الفيديو',
                        hintText: "حقل الفيديو (إختياري) يمكنك تركه فارغا",
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFd3142e)))),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    width:MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Color(0xFFd3142e),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text("إرسال العقار للمراجعة", style: TextStyle(
                        fontFamily: "Cairo",
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        if(!addEstateKey.currentState.validate()) {
                          _newTaskModalBottomSheet(context);
                        }
                        var respose =
                            await http.post('https://amlakyee.com/wp-json/wp/v2/real_estate',
                            body: jsonEncode({
                              "title": EstateTile.text,
                              "content": EstateDesc.text,
                              "_Length_text_field": EstateLength.text.toString(),
                              "_width_text_field": EstateWidth.text.toString(),
                              "location": estateLocationValue[1].toString(),
                              "estateType": estateTypeValue[1].toString(),
                              "Layers": LayersValue[1].toString(),
                              "land_type": landTypeValue[1].toString(),
                              "land_shape": land_shapeValue[1].toString(),
                              "building_materials": building_materialsValue[1].toString(),
                              "building_date": building_dateValue[1].toString(),
                              "sale_rent": ad_typeValue[1].toString(),
                              "sale_rent": ad_typeValue[1].toString(),
                              "meta_box": {
                                "_Length_text_field": EstateLength.text.toString(),
                                "_width_text_field": EstateWidth.text.toString(),
                                "_diwp_text_field": EstatePrice.text.toString(),
                                "estateAgentPhone_field": EstateAgentNumber.text.toString(),
                                "estate_youtube_link": EstateVideo.text,
                              },
                              // "featured_media": imageName,
                              "status": "pending",
                              "featured_media": widget.esImgId,
                            }),
                            headers: {
                              "Accept": "*/*",
                              "Accept-Encoding": "gzip, deflate, br",
                              "Connection": "keep-alive",
                              "Content-Type": "application/json",
                              "Authorization": "Bearer ${widget.userToken}"
                            }).then((http.Response response) async {
                          final int statusCode = response.statusCode;
                          if (statusCode == 201) {
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                'تم أرسال العقار للمراجعة',
                                style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
                              ),
                              backgroundColor: Colors.green,
                            ));
                            Future.delayed(const Duration(milliseconds: 2500), () {
                              Navigator.pop(context);
                            });
                          } else {
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                'حدث خطأ ما!',
                                style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                        return respose;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void _newTaskModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 120),
                  child: Text("يوجد هنالك حقل أو حقول إجبارية يجب تحديد قيمة لها!", style: TextStyle(color: Colors.red, fontFamily: "cairo", fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                child: RaisedButton(
                  color: Color(0xFFd3142e),
                  child: Text("حسنا", style: TextStyle(color: Colors.white, fontFamily: "cairo")),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      }
  );
}