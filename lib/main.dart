import 'package:amlaky/screens/CarsDetails.dart';
import 'package:amlaky/screens/details_page.dart';
import 'package:amlaky/screens/homePage.dart';
import 'package:amlaky/screens/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String notifiContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configOneSignal();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أملاكي',
      theme: ThemeData(
        dialogBackgroundColor: Color(0xfff6f8ff),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
        ),
        brightness: Brightness.light,
        primaryColor: Color(0xFF385C7B),
        accentColor: Color(0xFFd3142e),
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 17,
              color: Colors.black,
              height: 1.2,
              fontWeight: FontWeight.w500,
              fontFamily: "Cairo",
            ),
            caption: TextStyle(color: Colors.black45, fontSize: 10),
            bodyText1: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            )),
      ),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', ''), // Locale('ar', '') OR Other RTL locales
      ],
      locale: Locale('ar', '') ,// Locale('ar', '') OR Other RTL locales,
      home: SplashScreen(),
      initialRoute:SplashScreen.routeName,
      routes: {
        HomeScreen.routeName : (BuildContext contex) => HomeScreen(),
        SplashScreen.routeName : (BuildContext context) => SplashScreen(),
        DetailsPage.routeName : (BuildContext context) => DetailsPage(),
        CarsDetails.routeName : (BuildContext context) => CarsDetails(),
      },
    );
  }

  // oneSignal Notifigations
  void configOneSignal() async {
    await OneSignal.shared.init('1b71d532-d512-4243-8663-f887bc9d5c40');

    // show notifigation content
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      // CONTENT NOTIFIGATION
      notifiContent = notification.jsonRepresentation().replaceAll('\\n', '\n');
    });
  }
}



