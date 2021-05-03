import 'package:amlaky/apis/api_service.dart';
import 'package:amlaky/searchFliter/ByPrice_cars.dart';
import 'package:amlaky/searchFliter/Bydate_cars.dart';
import 'package:flutter/material.dart';

Widget CarsByPriceContainer(context) {
  return Container(
    height: MediaQuery.of(context).size.height * .7, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ),// Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: price_values.length,
        itemBuilder: (BuildContext context, int index) {
          var price = price_values[index];
          var name = price[0];
          var priceval = price[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ByCarsPrice( priceval, name),
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
                  ),

                ],
              ),
            ),
          );
        }
    ),
  );
}
Widget CarsByDateContainer(context) {
  return Container(
    height: MediaQuery.of(context).size.height * .7, // Change as per your requirement
    width: double.maxFinite, //
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ),// Change as per your requirement
    child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        physics: ScrollPhysics(),
        itemCount: Cars_Date.length,
        itemBuilder: (BuildContext context, int index) {
          var carsDate = Cars_Date[index];
          var name = carsDate[0];
          var dateval = carsDate[1];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .5,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ByCarsDate( dateval, name),
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
                  ),

                ],
              ),
            ),
          );
        }
    ),
  );
}
