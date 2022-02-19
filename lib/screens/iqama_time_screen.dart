import 'dart:convert';
import 'package:adhan/Utils/util.dart';
import 'package:adhan/component/slider.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/widget/waiting_widget.dart';
import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class IqamaTimeScreen extends StatefulWidget {
  const IqamaTimeScreen({Key? key}) : super(key: key);

  @override
  _IqamaTimeScreenState createState() => _IqamaTimeScreenState();
}

class _IqamaTimeScreenState extends State<IqamaTimeScreen> {

  DateFormat format = DateFormat("yMMMMEEEEd");
  DateFormat hourFormat = DateFormat("HH:mm");
  final _today = HijriCalendar.now();
  GeoCode geoCode = GeoCode();
  Position? currentLocation;
  List<Placemark>? placeMarks;
  String fajr ="--:--";
  String sunrise = "--:--";
  String dhuhr ="--:--";
  String asr = "--:--";
  String maghrib = "--:--";
  String isha = "--:--";


  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      getUserLocation();
    });

    super.initState();
  }

  Future<Position> locateUser() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {

        return Future.error('Location Not Available');
      }
    } else {
      try{
        return Geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }catch(e){print(e);}
    }
    return Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    adhan.CalculationParameters params = adhan.CalculationMethod.MuslimWorldLeague();
    params.madhab = adhan.Madhab.Hanafi;
    getPayerTimes(context);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
            size: size.height*0.03,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height*0.05,
              width: size.width*0.6,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: const Offset(
                        1, 7), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(size.height*0.02)
                ),
              ),
              child: Center(
                child: Text(
                  "Iqamah Times",
                  style: TextStyle(
                      fontSize: size.height*0.03,
                      color:Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.05,),

            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(size.height*0.06)
                  ),
                  image: DecorationImage(
                      image: AssetImage(
                          "images/custom-shape.png"
                      ),
                      fit: BoxFit.cover
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.23,
                            decoration: BoxDecoration(
                              color:kSecondaryColor,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Fajr",
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.03,),
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.6,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                fajr,
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color:kPrimaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.23,
                            decoration: BoxDecoration(
                              color:kSecondaryColor,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Dhuhr",
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.03,),
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.6,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                dhuhr,
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color:kPrimaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.23,
                            decoration: BoxDecoration(
                              color:kSecondaryColor,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Asr",
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.03,),
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.6,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                asr,
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color:kPrimaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.23,
                            decoration: BoxDecoration(
                              color:kSecondaryColor,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Maghrib",
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.03,),
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.6,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                maghrib,
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color:kPrimaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.23,
                            decoration: BoxDecoration(
                              color:kSecondaryColor,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Isha",
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.03,),
                          Container(
                            height: size.height*0.05,
                            width: size.width*0.6,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.015),
                            ),
                            child: Center(
                              child: Text(
                                isha,
                                style: TextStyle(
                                    fontSize: size.height*0.02,
                                    color:kPrimaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height*0.01,),

                      const BuildSlider(paginationColor: Colors.white,),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPayerTimes(BuildContext context) async {
    // setState(() {
    //   showSpinner = true;
    // });
    var response = await http.get(
      Uri.parse("http://api.aladhan.com/v1/calendar?latitude=${31.897851}&longitude=${35.941489}&method=1&month=${DateTime.now().month}&year=${DateTime.now().year}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        fajr = hourFormat.parse(jsonResponse["data"][DateTime.now().day-1]['timings']['Fajr'].toString().substring(0,5)).add(Duration(minutes: 30)).toString().substring(11,16);
        dhuhr = hourFormat.parse(jsonResponse["data"][DateTime.now().day-1]['timings']['Dhuhr'].toString().substring(0,5)).add(Duration(minutes: 15)).toString().substring(11,16);
        asr = hourFormat.parse(jsonResponse["data"][DateTime.now().day-1]['timings']['Asr'].toString().substring(0,5)).add(Duration(minutes: 15)).toString().substring(11,16);
        maghrib = hourFormat.parse(jsonResponse["data"][DateTime.now().day-1]['timings']['Maghrib'].toString().substring(0,5)).add(Duration(minutes: 5)).toString().substring(11,16);
        isha = hourFormat.parse(jsonResponse["data"][DateTime.now().day-1]['timings']['Isha'].toString().substring(0,5)).add(Duration(minutes: 10)).toString().substring(11,16);
      });
    } else {
      // setState(() {
      //   showSpinner = false;
      // });
      var jsonResponse = jsonDecode(response.body);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed: $jsonResponse.');

      showSnackBar(
          context,
          translate(context,'somethingWentWrong'),
          translate(context,'pleaseTryAgainLater'),
          "error");
    }
  }


}
