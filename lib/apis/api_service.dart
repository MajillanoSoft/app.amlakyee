library constants;

import 'package:http/http.dart' as http;
import 'dart:convert';

// website URL
const String Webaite_URL = "https://amlakyee.com/";

final CarsBaseUrl = '$Webaite_URL/wp-json/wp/v2/cars?_embed';

Future<List> fetchCars() async {
  final response =
      await http.get(CarsBaseUrl, headers: {'Accept': 'application/json'});
  var toJson = jsonDecode(response.body);
  return toJson;
}

final RealEstatesBaseUrl = '$Webaite_URL/wp-json/wp/v2/real_estate?_embed';

Future<List> fetchEstates() async {
  final response = await http
      .get(RealEstatesBaseUrl, headers: {'Accept': 'application/json'});
  var toJson = jsonDecode(response.body);
  return toJson;
}

final Real_EstatesSearchUrl =
    '$Webaite_URL/wp-json/wp/v2/real_estate?_embed&fields=title,content.rendered&search=';

Future<List> fetchReal_EstatesSearch(query) async {
  final response = await http.get(Real_EstatesSearchUrl + query,
      headers: {'Accept': 'application/json'});
  var conToJson = jsonDecode(response.body);
  return conToJson;
}

final Real_EstatesSearcIdhUrl =
    '$Webaite_URL/wp-json/wp/v2/real_estate/?_embed&filter[p]=';

Future<List> REstatesSearcIdhUrl(query) async {
  final response = await http.get(Real_EstatesSearcIdhUrl + query,
      headers: {'Accept': 'application/json'});
  var conToJson = jsonDecode(response.body);
  return conToJson;
}

final CarsSearchUrl =
    '$Webaite_URL/wp-json/wp/v2/cars?_embed&fields=title,content.rendered&search=';

Future<List> fetchCarsSearch(query) async {
  final response = await http
      .get(CarsSearchUrl + query, headers: {'Accept': 'application/json'});
  var conToJson = jsonDecode(response.body);
  return conToJson;
}

final CarsSearcIdhUrl = '$Webaite_URL/wp-json/wp/v2/cars/?_embed&filter[p]=';

Future<List> CarsSearcbyIdhUrl(query) async {
  final response = await http
      .get(CarsSearcIdhUrl + query, headers: {'Accept': 'application/json'});
  var conToJson = jsonDecode(response.body);
  return conToJson;
}

const List<dynamic> CUSTOM_CATEGORIES = [
  // cars colors terms ids
  ["أبيض", "assets/icons/colors/white.png", 416],
  ["احمر", "assets/icons/colors/red.png", 412],
  ["احمر غامق", "assets/icons/colors/dark-red.png", 413],
  ["احمر فاتح", "assets/icons/colors/light-red.png", 414],
  ["اصفر", "assets/icons/colors/yellow.png", 421],
  ["اصفر غامق", "assets/icons/colors/dark-yellow.png", 422],
  ["اصفر فاتح", "assets/icons/colors/light-yellow.png", 423],
  ["اخضر", "assets/icons/colors/green.png", 417],
  ["اخضر غامق", "assets/icons/colors/dark-green.png", 418],
  ["اخضر فاتح", "assets/icons/colors/light-green.png", 419],
  ["الازرق", "assets/icons/colors/blue.png", 401],
  ["الازرق السمائي", "assets/icons/colors/sky-blue.png", 404],
  ["الازرق الغامق", "assets/icons/colors/dark-blue.png", 406],
  ["الاسود", "assets/icons/colors/black.png", 403],
  ["البني", "assets/icons/colors/brouwn.png", 405],
  ["البيجي", "assets/icons/colors/dark-brown.png", 402],
  ["الرمادي", "assets/icons/colors/grey.png", 407],
  ["البرتقالي", "assets/icons/colors/light-orange.png", 410],
  ["برتقالي غامق", "assets/icons/colors/orange.png", 411],
  ["بنفسجي", "assets/icons/colors/purb.png", 424],
];

// Tab 2 page category ID
//const int PAGE2_CATEGORY_ID = 38;

// Custom categories in search tab
// Array in format
// ["Category Name", "Image Link", "Category ID"]
const List<dynamic> Cars_Location = [
  // cars locations terms ids
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

const List<dynamic> Cars_Date = [
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

const List<dynamic> Cars_Type = [
  // cars locations terms ids
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

// location = 32 نينوى
// location = 36 واسط

const List<dynamic> CarsMv = [
  // cars Montion victor terms ids
  ["أوتوماتيك", 487],
  ["عادي", 488],
  ["كهربائي", 489],
];

const List<dynamic> land_type = [
  // cars Montion victor terms ids
  ["طابو زراعي", 61],
  ["طابو صرف", 60],
  ["عقد زراعي", 62],
  ["مكاتبة", 63],
];

const List<dynamic> estate_Location = [
  // cars Montion victor terms ids
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

const List<dynamic> estate_buildDate = [
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

const List<dynamic> estate_type = [
  // cars Montion victor terms ids
  ["سكني", 57],
  ["عرصة", 58],
  ["مكان تجاري", 59],
];

const List<dynamic> ad_type = [
  ["بيع", 490],
  ["أيجار", 491],
];

const List<dynamic> price_values = [
  // cars colors terms ids
  ["أكثر من 50000\$", 10000000],
  ["50000\$ أو أقل", 50000],
  ["45000\$ أو أقل", 45000],
  ["40000\$ أو اقل", 40000],
  ["35000\$ أو أقل", 35000],
  ["30000\$ أو أقل", 30000],
  ["25000\$ أو أقل", 25000],
  ["20000\$ أو أقل", 20000],
  ["15000\$ أو أقل", 15000],
  ["10000\$ أو أقل", 10000],
];

const List<dynamic> estates_price_values = [
  // cars colors terms ids
  ["أكثر من 500 مليون", 10000000],
  ["500 مليون أو أقل", 500],
  ["450 مليون أو أقل", 450],
  ["400 مليون أو أقل", 400],
  ["350 مليون أو أقل", 350],
  ["300 مليون أو أقل", 300],
  ["250 مليون أو أقل", 250],
  ["200 مليون أو أقل", 200],
  ["150 مليون أو أقل", 150],
  ["100 مليون أو أقل", 100],
];
