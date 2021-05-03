import 'dart:convert';
import 'dart:io';
import 'package:amlaky/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'UploadMediaCar.dart';

class AddCars extends StatefulWidget {
  final String userToken;
  final int ImgId;
  AddCars({this.userToken, this.ImgId});
  @override
  _AddCarsState createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {

  var addEstateKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var CarTile = TextEditingController();
  var CarDesc = TextEditingController();
  var CarPrice = TextEditingController();
  var CarsAgentNumber = TextEditingController();
  var distance = TextEditingController();
  var carsVideo = TextEditingController();

  bool _validate = false;

  var carTypeValue;
  List carTypeItems = [
    ["AC", 121],
    ["AC PROPULSION", 122],
    ["ACURA", 123],
    ["A.D. TRAMONTANA", 124],
    ["ALFA ROMEO", 125],
    ["ALTERNATIVE CARS", 127],
    ["ALMAC", 126],
    ["AMUZA", 128],
    ["ANTEROS", 129],
    ["ARASH", 130],
    ["ARIEL", 131],
    ["ARRINERA", 132],
    ["ASL", 133],
    ["ASTERIO", 134],
    ["ASTON MARTIN", 135],
    ["AUDI", 136],
    ["BAC", 137],
    ["BAJAJ", 138],
    ["BEIJING AUTOMOBILE WORKS", 139],
    ["BENTLEY", 140],
    ["BMW", 141],
    ["BOLLORÉ", 142],
    ["BOLWELL", 143],
    ["BRILLIANCE / HUACHEN", 144],
    ["BRISTOL", 145],
    ["BRITISH LEYLAND", 146],
    ["BRM BUGGY", 147],
    ["BROOKE", 148],
    ["BUDDY", 149],
    ["BUFORI", 150],
    ["BUGATTI", 151],
    ["BUICK", 152],
    ["BYD", 153],
    ["CADILLAC", 154],
    ["CAPARO", 155],
    ["CARBONTECH", 156],
    ["CARICE", 157],
    ["CHANG'AN", 158],
    ["CHANGHE", 159],
    ["CHERY", 160],
    ["CHEVROLET", 161],
    ["CHEVRON", 162],
    ["CHRYSLER", 164],
    ["CITROËN", 163],
    ["COMMUTER CARS", 165],
    ["CONNAUGHT", 166],
    ["COVINI", 167],
    ["DACIA", 168],
    ["DAIHATSU", 169],
    ["DATSUN", 170],
    ["DE LA CHAPELLE", 171],
    ["DIARDI", 173],
    ["DMC", 172],
    ["DODGE", 174],
    ["DONGFENG", 176],
    ["DONKERVOORT", 175],
    ["DONTO", 177],
    ["DS AUTOMOBILES", 178],
    ["DYNASTI ELECTRIC CAR CORP", 179],
    ["E-VADE", 180],
    ["EFFEDI", 181],
    ["EGY-TECH ENGINEERING", 182],
    ["ELECTRIC RACEABOUT", 183],
    ["ELFIN", 184],
    ["EMGRAND", 185],
    ["ENGLON", 186],
    ["ETERNITI", 187],
    ["ETOX", 188],
    ["EQUUS", 189],
    ["EXAGON", 190],
    ["FARALLI & MAZZANTI", 191],
    ["FAW", 192],
    ["FERRARI", 193],
    ["FIAT", 194],
    ["FISKER", 195],
    ["FODAY", 196],
    ["FORCE", 197],
    ["FORD", 198],
    ["FORD AUSTRALIA", 199],
    ["FORD GERMANY", 200],
    ["FORNASARI", 201],
    ["FRASER", 202],
    ["GAC GROUP", 203],
    ["GALPIN", 204],
    ["GEELY", 205],
    ["GENESIS", 206],
    ["GIBBS", 207],
    ["GILLET", 208],
    ["GINETTA", 209],
    ["GMC", 210],
    ["GONOW", 211],
    ["GREAT WALL / CHANGCHENG", 212],
    ["GREENTECH AUTOMOTIVE", 213],
    ["GRINNALL", 214],
    ["GTA MOTOR", 215],
    ["GUMPERT", 216],
    ["GURGEL", 217],
    ["HENNESSEY", 218],
    ["HINDUSTAN", 219],
    ["HOLDEN", 220],
    ["HONDA", 221],
    ["HONGQI", 222],
    ["HRADYESH", 223],
    ["HTT TECHNOLOGIES", 224],
    ["HULME", 225],
    ["HYUNDAI", 226],
    ["ICML", 227],
    ["IFR", 228],
    ["IRAN KHODRO", 229],
    ["IKCO", 230],
    ["IMPERIA", 231],
    ["INFINITI", 232],
    ["IVM", 233],
    ["INVICTA", 234],
    ["ISDERA", 235],
    ["ISUZU", 236],
    ["JAC", 237],
    ["JAGUAR", 238],
    ["JEEP", 239],
    ["JENSEN MOTORS", 240],
    ["JETCAR", 241],
    ["JONWAY", 242],
    ["JOSS", 243],
    ["KAIPAN", 244],
    ["KANTANKA", 245],
    ["KARMA", 246],
    ["KOENIGSEGG", 247],
    ["KORRES", 248],
    ["KIA", 249],
    ["KIAT", 250],
    ["KISH KHODRO", 251],
    ["KTM", 252],
    ["LADA", 253],
    ["LAMBORGHINI", 254],
    ["LANCIA", 255],
    ["LAND ROVER", 256],
    ["LANDWIND", 257],
    ["LARAKI", 258],
    ["LEBLANC", 259],
    ["LEITCH", 260],
    ["LEOPARD", 261],
    ["LEXUS", 262],
    ["LI-ION", 263],
    ["LIFAN", 264],
    ["LIGHTNING", 265],
    ["LINCOLN", 266],
    ["LISTER", 267],
    ["LOCAL MOTORS", 268],
    ["LOBINI", 269],
    ["LOTEC", 270],
    ["LOTUS CARS", 271],
    ["LUCRA CARS", 272],
    ["LUXGEN", 273],
    ["MAHINDRA", 274],
    ["MARUSSIA", 275],
    ["MARUTI SUZUKI", 276],
    ["MASERATI", 277],
    ["MASTRETTA", 278],
    ["MAZDA", 279],
    ["MCLAREN", 280],
    ["MERCEDES-BENZ", 281],
    ["MG", 282],
    ["MICRO", 283],
    ["MINI", 284],
    ["MITSUBISHI", 285],
    ["MITSUOKA", 286],
    ["MORGAN", 287],
    ["MULLEN", 288],
    ["MYCAR", 289],
    ["MYVI-PERODUA", 290],
    ["NISSAN", 291],
    ["NOBLE", 292],
    ["NOTA", 293],
    ["OLDSMOBILE", 294],
    ["OPEL", 295],
    ["OPTIMAL ENERGY", 296],
    ["ORCA", 297],
    ["OLTCIT", 298],
    ["PAGANI", 299],
    ["PANHARD", 300],
    ["PANOZ", 301],
    ["PERANA", 302],
    ["PERODUA", 303],
    ["PEUGEOT", 304],
    ["P.G.O.", 305],
    ["POLARSUN", 306],
    ["PLYMOUTH", 307],
    ["PORSCHE", 308],
    ["PROTO", 309],
    ["PROTON", 310],
    //["PROTON", 311],
    ["PURITALIA", 312],
    ["QOROS", 313],
    ["QVALE", 314],
    ["RADICAL", 315],
    ["RELIANT", 316],
    ["RENAULT", 317],
    ["REVA", 318],
    ["RIMAC", 319],
    ["RINSPEED", 320],
    ["RODING", 321],
    ["ROEWE", 322],
    ["ROLLS-ROYCE", 323],
    ["ROSSIN-BERTIN", 324],
    ["ROSSION", 325],
    ["ROVER", 326],
    ["SAAB", 327],
    ["SALEEN", 328],
    ["SAIC-GM-WULING", 329],
    ["SAIPA", 330],
    ["SAKER", 331],
    ["SAMSUNG", 332],
    ["SAN", 333],
    ["SBARRO", 334],
    ["SCION", 335],
    ["SEAT", 336],
    ["SHANGHAI MAPLE", 337],
    ["SIN", 338],
    ["ŠKODA", 339],
    ["SMART", 340],
    ["SPADA VETTURE SPORT", 341],
    ["SPYKER", 342],
    ["SSANGYONG", 343],
    ["SSC NORTH AMERICA", 344],
    ["STREET & RACING TECHNOLOGY", 345],
    ["SUBARU", 346],
    ["SUZUKI", 347],
    ["TANOM", 348],
    ["TATA", 349],
    ["TAURO", 350],
    ["TAWON CAR", 351],
    ["TD CARS", 352],
    ["TESLA", 353],
    ["THAI RUNG", 354],
    ["TOYOTA", 355],
    ["TREKKA", 356],
    ["TRIDENT", 357],
    ["TRIUMPH", 358],
    ["TROLLER", 359],
    ["TRUMPCHI", 360],
    ["TUSHEK", 361],
    ["TVR", 362],
    ["TVS", 363],
    ["ULTIMA", 364],
    ["UMM", 365],
    ["UEV", 366],
    ["URI", 367],
    ["UAZ", 368],
    ["VAUXHALL MOTORS", 369],
    ["VECTOR", 370],
    ["VENCER", 371],
    ["VENIRAUTO", 372],
    ["VENTURI", 373],
    ["VEPR", 374],
    ["VOLKSWAGEN", 375],
    ["VOLVO", 376],
    ["VINFAST", 377],
    ["W MOTORS", 378],
    ["WALLYSCAR", 379],
    ["WESTFIELD", 380],
    ["WHEEGO", 381],
    ["WIESMANN", 382],
    ["XENIA", 383],
    ["YES!", 384],
    ["YOUABIAN PUMA", 385],
    ["ZASTAVA AUTOMOBILES", 386],
    ["ZENDER CARS", 387],
    ["ZENOS CARS", 388],
    ["ZENVO", 389],
    ["ZIL", 390],
    ["ZX AUTO", 391],
  ];

  var colorValue;
  List colorItems = [
    ["أبيض", 416],
    ["احمر", 412],
    ["احمر غامق", 413],
    ["احمر فاتح", 414],
    ["اصفر", 421],
    ["اصفر غامق", 422],
    ["اصفر فاتح", 423],
    ["اخضر", 417],
    ["اخضر غامق", 418],
    ["اخضر فاتح", 419],
    ["الازرق", 401],
    ["الازرق السمائي", 404],
    ["الازرق الغامق", 406],
    ["الاسود", 403],
    ["البني", 405],
    ["البيجي", 402],
    ["الرمادي", 407],
    ["البرتقالي", 410],
    ["برتقالي غامق", 411],
    ["بنفسجي", 424],
  ];

  var carLocationValue;
  List carLocationItems = [
    ["اربيل", 38],
    ["الأنبار", 40],
    ["البصرة", 42],
    ["السليمانية", 54],
    ["القادسية", 52],
    ["المثنى", 49],
    ["النجف الأشرف", 50],
    ["بابل", 41],
    ["بغداد", 39],
    ["حلبجة", 56],
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

  var incoming_typeValue;
  List incoming_typeItems = [
    ["وارد امريكي", 396],
    ["وارد اوربي", 398],
    ["وارد خليجي", 394],
    ["وارد صيني", 399],
    ["وارد كندي", 400],
    ["وارد كوري", 395],
    ["وارد ياباني", 397],
  ];

  var Motion_vectorValue;
  List Motion_vectorItems = [
    ["أوتوماتيك", 487],
    ["عادي", 488],
    ["كهربائي", 489],
  ];

  var carisfreeValue;
  List carisfreeItems = [
    ["حرة", 512],
    ["مطلوبة", 513],
  ];

  var annualTypeValue;
  List annualTypeItems = [
    ["نعم", 514],
    ["لا", 515],
  ];

  var carHarmsValue;
  List carHarmsItems = [
    ["نعم", 518],
    ["لا", 519],
  ];

  var carnumberValue;
  List carnumberItems = [
    ["نعم", 516],
    ["لا", 517],
  ];

  var CarsponsorValue;
  List CarsponsorItems = [
    ["نعم", 520],
    ["لا", 521],
  ];

  var carsAgentLocationValue;
  List carsAgentLocationItems = [
    ["أربيل", 522],
    ["الأنبار", 523],
    ["البصرة", 525],
    ["السليمانية", 526],
    ["القادسية", 527],
    ["المثنى", 528],
    ["النجف الأشرف", 529],
    ["بابل", 530],
    ["بغداد", 524],
    ["حلبجة", 531],
    ["دهوك", 532],
    ["ديالى", 533],
    ["ذي قار", 534],
    ["صلاح الدين", 535],
    ["كربلاء", 536],
    ["كركوك", 537],
    ["ميسان", 538],
    ["نينوى", 539],
    ["واسط", 540],
  ];

  var date_carsValue;
  List date_carsItems = [
    ["2021", 545],
    ["2020", 434],
    ["2019", 435],
    ["2018", 436],
    ["2017", 437],
    ["2016", 438],
    ["2015", 439],
    ["2014", 440],
    ["2013", 441],
    ["2012", 442],
    ["2011", 443],
    ["2010", 444],
    ["2009", 445],
    ["2008", 446],
    ["2007", 447],
    ["2006", 448],
    ["2005", 449],
    ["2004", 450],
    ["2003", 451],
    ["2002", 452],
    ["2001", 453],
    ["2000", 454],
    ["1999", 455],
    ["1998", 456],
    ["1997", 457],
    ["1996", 458],
    ["1995", 459],
    ["1994", 460],
    ["1993", 461],
    ["1992", 462],
    ["1991", 463],
    ["1990", 464],
    ["1989", 465],
    ["1988", 466],
    ["1987", 467],
    ["1986", 468],
    ["1985", 469],
    ["1984", 470],
    ["1983", 471],
    ["1982", 472],
    ["1981", 473],
    ["1980", 474],
    ["1979", 475],
    ["1978", 476],
    ["1977", 477],
    ["1976", 478],
    ["1975", 479],
    ["1974", 480],
    ["1973", 481],
    ["1972", 482],
    ["1971", 483],
    ["1970", 484],
  ];

  var fuel_typeValue;
  List fuel_typeItems = [
    ["بانزين", 392],
    ["كاز", 393],
  ];

  var distance_pointsValue;
  List distance_pointsItems = [
    ["KM", "KM"],
    ["ML", "ML"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFd3142e),
        title: Text(
          "أضافة سيارة",
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
                    controller: CarTile,
                    decoration: InputDecoration(
                        labelText: 'عنوان السيارة',
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
                    controller: CarDesc,
                    decoration: InputDecoration(
                        labelText: 'تفاصيل عن السيارة',
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: CarPrice,
                    decoration: InputDecoration(
                        labelText: 'السعر - بالدولار',
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
                    controller: distance,
                    decoration: InputDecoration(
                        labelText: "المسافة المقطوعة",
                        labelStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                    validator: (value) {
                      if(value.length < 1){
                        return 'هذا الحقل إجباري';
                      }else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
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
                      hint: Text("- وحدة القياس",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: distance_pointsValue,
                      onChanged: (newdistance_pointsValue) {
                        setState(() {
                          distance_pointsValue = newdistance_pointsValue;
                        });
                      },
                      items: distance_pointsItems.map((valueItem) {
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    controller: CarsAgentNumber,
                    decoration: InputDecoration(
                        labelText: 'رقم هاتف صاحب السيارة',
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
                      value: carLocationValue,
                      onChanged: (newcarLocationValue) {
                        setState(() {
                          carLocationValue = newcarLocationValue;
                        });
                      },
                      items: carLocationItems.map((valueItem) {
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
                      hint: Text("أختر ماركة السيارة",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: carTypeValue,
                      onChanged: (newcarTypeValue) {
                        setState(() {
                          carTypeValue = newcarTypeValue;
                        });
                      },
                      items: carTypeItems.map((valueItem) {
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
                      hint: Text("أختر اللون",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: colorValue,
                      onChanged: (newcolorValue) {
                        setState(() {
                          colorValue = newcolorValue;
                        });
                      },
                      items: colorItems.map((valueItem) {
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
                      hint: Text("أختر نوع الوارد",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: incoming_typeValue,
                      onChanged: (newincoming_typeValue) {
                        setState(() {
                          incoming_typeValue = newincoming_typeValue;
                        });
                      },
                      items: incoming_typeItems.map((valueItem) {
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
                      hint: Text("أختر نوع ناقل الحركة",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: Motion_vectorValue,
                      onChanged: (newMotion_vectorValue) {
                        setState(() {
                          Motion_vectorValue = newMotion_vectorValue;
                        });
                      },
                      items: Motion_vectorItems.map((valueItem) {
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
                      hint: Text("أختر سنة الصنع",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: date_carsValue,
                      onChanged: (newdate_carsValue) {
                        setState(() {
                          date_carsValue = newdate_carsValue;
                        });
                      },
                      items: date_carsItems.map((valueItem) {
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
                      hint: Text("أختر نوع الوقود",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: fuel_typeValue,
                      onChanged: (newfuel_typeValue) {
                        setState(() {
                          fuel_typeValue = newfuel_typeValue;
                        });
                      },
                      items: fuel_typeItems.map((valueItem) {
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
                      hint: Text("هل السيارة حرة أم مطلوبة؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: carisfreeValue,
                      onChanged: (newcarisfreeValue) {
                        setState(() {
                          carisfreeValue = newcarisfreeValue;
                        });
                      },
                      items: carisfreeItems.map((valueItem) {
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
                      hint: Text("هل السنوية بأسم البائع؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: annualTypeValue,
                      onChanged: (newannualTypeValue) {
                        setState(() {
                          annualTypeValue = newannualTypeValue;
                        });
                      },
                      items: annualTypeItems.map((valueItem) {
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
                      hint: Text("هل السيارة مرقمة أم لا؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: carnumberValue,
                      onChanged: (newcarnumberValue) {
                        setState(() {
                          carnumberValue = newcarnumberValue;
                        });
                      },
                      items: carnumberItems.map((valueItem) {
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
                      hint: Text("هل السيارة تحمل ضررا؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: carHarmsValue,
                      onChanged: (newcarHarmsValue) {
                        setState(() {
                          carHarmsValue = newcarHarmsValue;
                        });
                      },
                      items: carHarmsItems.map((valueItem) {
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
                      hint: Text("هل السيارة مكفولة أم لا؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: CarsponsorValue,
                      onChanged: (newCarsponsorValue) {
                        setState(() {
                          CarsponsorValue = newCarsponsorValue;
                        });
                      },
                      items: CarsponsorItems.map((valueItem) {
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
                      hint: Text("مكان تواجد صاحب السيارة؟",
                          style: TextStyle(fontFamily: "Cairo")),
                      value: carsAgentLocationValue,
                      onChanged: (newcarsAgentLocationValue) {
                        setState(() {
                          carsAgentLocationValue = newcarsAgentLocationValue;
                        });
                      },
                      items: carsAgentLocationItems.map((valueItem) {
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
                    controller: carsVideo,
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
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Color(0xFFd3142e),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text("إرسال الإعلان للمراجعة", style: TextStyle(
                        fontFamily: "cairo",
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        if(!addEstateKey.currentState.validate()) {
                          _newTaskModalBottomSheet(context);
                        }
                        var respose =
                            await http.post('https://amlakyee.com/wp-json/wp/v2/cars',
                            body: jsonEncode({
                              "title": CarTile.text,
                              "content": CarDesc.text,
                              "locationCars": carLocationValue[1].toString(),
                              "carType": carTypeValue[1].toString(),
                              "color": colorValue[1].toString(),
                              "incoming_type": incoming_typeValue[1].toString(),
                              "Motion_vector": Motion_vectorValue[1].toString(),
                              "date_cars": date_carsValue[1].toString(),
                              "fuel_type": fuel_typeValue[1].toString(),
                              "carisfree": carisfreeValue[1].toString(),
                              "annualType": annualTypeValue[1].toString(),
                              "carnumber": carnumberValue[1].toString(),
                              "carHarms": carHarmsValue[1].toString(),
                              "Carsponsor": CarsponsorValue[1].toString(),
                              "carsAgentLocation": carsAgentLocationValue[1].toString(),
                              "meta_box": {
                                "_cars_text_field": CarPrice.text.toString(),
                                "_carsAgentPhone_text_field": CarsAgentNumber.text.toString(),
                                "_distance_text_field": distance.text.toString(),
                                "_distance_select_fieldselect": distance_pointsValue[1].toString(),
                                "cars_youtube_link": carsVideo.text,
                              },
                              "featured_media": widget.ImgId,
                              "status": "pending"
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
                                'تم أرسال السيارة للمراجعة',
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