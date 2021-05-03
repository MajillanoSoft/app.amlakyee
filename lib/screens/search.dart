import 'package:amlaky/apis/api_service.dart';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:amlaky/screens/properties.dart';
import 'package:amlaky/screens/settings.dart';
import 'package:amlaky/searchFliter/Ad_Type_Estate.dart';
import 'package:amlaky/searchFliter/PlaceType.dart';
import 'package:amlaky/searchFliter/building_date.dart';
import 'package:amlaky/searchFliter/carsLocation.dart';
import 'package:amlaky/searchFliter/carsMv.dart';
import 'package:amlaky/searchFliter/carsType.dart';
import 'package:amlaky/searchFliter/estateLocation.dart';
import 'package:amlaky/searchFliter/estate_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CarsSearchResult.dart';
import 'EstatesSearchResult.dart';
import 're_searchbyId.dart';
import 'cars_searchbyId.dart';
import 'category_articles.dart';
import 'cars_price_date.dart';
import 'estates_by_price.dart';
import 'homePage.dart';
import 'AgentsList.dart';
import 'SigninScreen.dart';
import 'package:amlaky/screens/privicy_policy.dart';

class SearchScreen extends StatefulWidget {
  bool AgentsTab;
  bool ADsTab;
  bool SearchTab;
  SearchScreen({Key key, this.ADsTab, this.AgentsTab, this.SearchTab})
      : super(key: key);
  static const routeName = 'searchscreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool AgentsTab = true;
  bool ADsTab = true;
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
    getuserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool AgentsTabFalse = widget.AgentsTab;
    bool ADsTabFalse = widget.ADsTab;
    bool SearchTabFalse = widget.SearchTab;


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xfff6f8ff),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black45),
          centerTitle: true,
          leading: SearchTabFalse == true
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
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                })
          ],
          backgroundColor: Colors.transparent,
          title: Text(
            'البحث',
            style: TextStyle(fontFamily: "Cairo", color: Colors.black54),
          ),
        ),
        drawer: _buildDrawer(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: RsSearchPage());
                    },
                    child: _buildSearchBar(context)),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: RsSearchIdPage());
                    },
                    child: _buildSearchRebyIdBar(context)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب المحافظة',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content:
                                    estatesLocationDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/placeholder.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "المحافظة",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب نوع العقار',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: estatesTypeDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/information.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "نوع العقار",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب نوع الأرض',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: landTypeDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/earth-type.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "نوع الأرض",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب نوع الإعلان',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: AdTypeDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/information.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "نوع الإعلان",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب سعر العقار',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: EstatesByPriceContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/dollar.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "السعر",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب سنة البناء',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: buildingDateDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/calendar.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "سنة البناء",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),

                // cars search form
                GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: CarsSearchPage());
                    },
                    child: _buildCarsSearchBar(context)),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: CarsSearchIdPage());
                    },
                    child: _buildCarsbyIdSearchBar(context)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب المحافظة',
                                  style: TextStyle(
                                      fontFamily: "Cairo", fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: carsLocationDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/placeholder.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "المحافظة",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب ماركة السيارة',
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: CarsTypeDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/information.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "الماركة",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب لون السيارة',
                                  style: TextStyle(
                                      fontFamily: "Cairo", fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: setupAlertDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/color-wheel.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "اللون",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب نوع ناقل الحركة',
                                  style: TextStyle(
                                      fontFamily: "Cairo", fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: carsMvDialoadContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/handbrake.svg",
                              width: 23,
                            ),
                            Container(
                              child: Text(
                                "ناقل الحركة",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 13),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب سعر السيارة',
                                  style: TextStyle(
                                      fontFamily: "Cairo", fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: CarsByPriceContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/dollar.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "السعر",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: AlertDialog(
                                elevation: 5,
                                title: Text(
                                  'بحث حسب سنة الصنع',
                                  style: TextStyle(
                                      fontFamily: "Cairo", fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                content: CarsByDateContainer(context),
                              ),
                            );
                          }),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * .42,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/calendar.svg",
                              width: 25,
                            ),
                            Container(
                              child: Text(
                                "الموديل",
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ));
  }

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
              setState(() {
                ADsTab == false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Properties(
                            ADsTab: ADsTab,
                          )));
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
              Navigator.pop(context);
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

Widget setupAlertDialoadContainer(context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .7, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: CUSTOM_CATEGORIES.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = CUSTOM_CATEGORIES[index];
          var name = cat[0];
          var image = cat[1];
          var catId = cat[2];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: SizedBox(
                          width: 30, height: 30, child: Image.asset(image))),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

// setup dilog to show Cars Locations
Widget carsLocationDialoadContainer(context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .7, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: Cars_Location.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = Cars_Location[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarsLocationArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

// setup dilog to show Cars Mv
Widget carsMvDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .35, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: CarsMv.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = CarsMv[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarsMvArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

// setup dilog to show Cars Type
Widget CarsTypeDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .7, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: Cars_Type.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = Cars_Type[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarsTypeArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget estatesLocationDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .45, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: estate_Location.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = estate_Location[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => estateLocationArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget estatesTypeDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .35, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: estate_type.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = estate_type[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EstateTypeArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget landTypeDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .45, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: land_type.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = land_type[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => landTypeArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget AdTypeDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .25, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: ad_type.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = ad_type[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => adArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget buildingDateDialoadContainer(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height *
        .65, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ), // Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: estate_buildDate.length,
        itemBuilder: (BuildContext context, int index) {
          var cat = estate_buildDate[index];
          var name = cat[0];
          var catId = cat[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuildDateArticles(catId, name),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget _buildSearchBar(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.home,
              color: Colors.black54,
            ),
            Container(
              child: Text(
                "بحث في العقارات",
                style: TextStyle(fontFamily: "Cairo", fontSize: 14),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .17,
            ),
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

Widget _buildSearchRebyIdBar(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.home,
              color: Colors.black54,
            ),
            Container(
              child: Text(
                "بحث حسب رقم الإعلان",
                style: TextStyle(fontFamily: "Cairo", fontSize: 14),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .17,
            ),
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

Widget _buildCarsSearchBar(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.directions_car,
              color: Colors.black54,
            ),
            Container(
              child: Text(
                "بحث في السيارات",
                style: TextStyle(fontFamily: "Cairo"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .17,
            ),
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

Widget _buildCarsbyIdSearchBar(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.directions_car,
              color: Colors.black54,
            ),
            Container(
              child: Text(
                "بحث حسب رقم الإعلان",
                style: TextStyle(fontFamily: "Cairo", fontSize: 14),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .17,
            ),
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}
