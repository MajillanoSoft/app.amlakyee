import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebeef3),
      appBar: AppBar(
        title: Text('معلومات عن أملاكي',
            style: TextStyle(
                color: Colors.black87, fontSize: 16, fontFamily: "Cairo")),
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/img/png-icon.png',
              width: 90,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "تطبيق وسيط بين الوكيل ومالك العقار أو مالك السيارة وبين المشتري , الغاية منه توسيع نطاق العرض وأستقطاب الطلب في جميع انحاء العراق والعالم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.8, color: Colors.black54, fontFamily: 'Cairo'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: Text(
                  "Version 1.2.5",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.4, color: Colors.black87),
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 2,
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  const url = 'https://www.facebook.com/messages/t/amlaky101';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/messenger.svg',
                    width: 35,
                  ),
                  title: Text('راسلنا على الفيسبوك',
                      style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text(
                    "Amlaky",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  const url = 'mailto:info@amlakyee.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/email.svg',
                    width: 35,
                  ),
                  title: Text(
                    'تواصل معنا على الإيميل',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                  subtitle: Text(
                    "info@amlakyee.com",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Share.share('ألق نظرة على موقع أملاكي: https://amlakyee.com');
                  Share.share('ألق نظرة على موقع أملاكي: https://amlakyee.com');
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/collaboration.svg",
                    width: 35,
                  ),
                  title: Container(
                    child: Text(
                      'مشاركة',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  isThreeLine: true,
                  subtitle: Text(
                    "مشاركة موقع أملاكي",
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Text(
            "جميع الحقوق وملكية تطبيق أملاكي لشركة عصر النجاح",
            style: TextStyle(
                fontSize: 13, fontFamily: "Cairo", color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
