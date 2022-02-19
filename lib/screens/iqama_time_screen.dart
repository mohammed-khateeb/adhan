import 'dart:convert';
import 'package:adhan/Utils/util.dart';
import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/component/slider.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/models/iqama_times.dart';
import 'package:adhan/widget/waiting_widget.dart';
import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class IqamaTimeScreen extends StatefulWidget {
  final bool isAdmin;

  const IqamaTimeScreen({Key? key, this.isAdmin = false}) : super(key: key);

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
  String fajr = "--:--";
  String sunrise = "--:--";
  String dhuhr = "--:--";
  String asr = "--:--";
  String maghrib = "--:--";
  String isha = "--:--";
  Duration _duration = Duration(hours: 0, minutes: 0);
  IqamaTimes iqamaTimes = IqamaTimes();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      if(widget.isAdmin){
        getIqamaTimes();
      }
      else{
        getIqamaTimes();
        getUserLocation();
      }


    });

    super.initState();
  }

  getIqamaTimes() async {
    Utils.showWaitingProgressDialog();
    await KhutbaApi.getIqamaTimes().then((value) {
      setState(() {
        iqamaTimes = value!;
      });
      if(widget.isAdmin){
        Utils.hideWaitingProgressDialog();
      }

    });
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
      try {
        return Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      } catch (e) {
        print(e);
      }
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();

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
            size: size.height * 0.03,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.05,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: const Offset(1, 7), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(size.height * 0.02)),
              ),
              child: Center(
                child: Text(
                  "Iqamah Times",
                  style: TextStyle(
                      fontSize: size.height * 0.03, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(size.height * 0.06)),
                  image: DecorationImage(
                      image: AssetImage("images/custom-shape.png"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Fajr",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdmin) {
                                await showDurationPicker(
                                  context: context,
                                  initialTime: Duration(minutes: 15),
                                ).then((value) {
                                  setState(() {
                                    if(value!=null)
                                    iqamaTimes.fajr = value.inMinutes;
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.015),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isAdmin
                                      ? iqamaTimes.fajr != null
                                          ? iqamaTimes.fajr.toString() + " min"
                                          : "type .."
                                      : fajr,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      color: kPrimaryColor),
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
                            height: size.height * 0.05,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Dhuhr",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdmin) {
                                await showDurationPicker(
                                  context: context,
                                  initialTime: Duration(minutes: 15),
                                ).then((value) {
                                  setState(() {
                                    if(value!=null)
                                      iqamaTimes.dhuhr = value.inMinutes;
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.015),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isAdmin
                                      ? iqamaTimes.dhuhr != null
                                      ? iqamaTimes.dhuhr.toString() + " min"
                                      : "type .."
                                      : dhuhr,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      color: kPrimaryColor),
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
                            height: size.height * 0.05,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Asr",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdmin) {
                                await showDurationPicker(
                                  context: context,
                                  initialTime: Duration(minutes: 15),
                                ).then((value) {
                                  setState(() {
                                    if(value!=null)
                                      iqamaTimes.asr = value.inMinutes;
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.015),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isAdmin
                                      ? iqamaTimes.asr != null
                                      ? iqamaTimes.asr.toString() + " min"
                                      : "type .."
                                      : asr,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      color: kPrimaryColor),
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
                            height: size.height * 0.05,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Maghrib",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdmin) {
                                await showDurationPicker(
                                  context: context,
                                  initialTime: Duration(minutes: 15),
                                ).then((value) {
                                  setState(() {
                                    if(value!=null)
                                      iqamaTimes.maghrib = value.inMinutes;
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.015),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isAdmin
                                      ? iqamaTimes.maghrib != null
                                      ? iqamaTimes.maghrib.toString() + " min"
                                      : "type .."
                                      : maghrib,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      color: kPrimaryColor),
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
                            height: size.height * 0.05,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                "Isha",
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdmin) {
                                await showDurationPicker(
                                  context: context,
                                  initialTime: Duration(minutes: 15),
                                ).then((value) {
                                  setState(() {
                                    if(value!=null)
                                      iqamaTimes.isha = value.inMinutes;
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.015),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isAdmin
                                      ? iqamaTimes.isha != null
                                      ? iqamaTimes.isha.toString() + " min"
                                      : "type .."
                                      : isha,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      color: kPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.isAdmin
                          ? Column(
                            children: [
                              Text(
                                  "this is time between the adhan\n and the iqamah in minutes.",
                                  style: TextStyle(
                                      fontSize: size.height * 0.03,
                                      color: Colors.white),
                                ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: changeTimes,
                                child: Container(
                                  height: size.height*0.04,
                                  width: size.width*0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(size.height*0.02),
                                  ),
                                  child: Center(
                                    child: Text("Change",
                                      style: TextStyle(fontSize: size.height*0.02,color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                          : const BuildSlider(
                              paginationColor: Colors.white,
                            ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
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

  changeTimes() async {
    Utils.showWaitingProgressDialog();
    await KhutbaApi.addNewIqamaTimes(iqamaTimes: iqamaTimes);
    Utils.hideWaitingProgressDialog();
    Utils.showSuccessAlertDialog("Success");

  }

  Future<void> getPayerTimes(BuildContext context) async {
    // setState(() {
    //   showSpinner = true;
    // });
    var response = await http.get(
      Uri.parse(
          "http://api.aladhan.com/v1/calendar?latitude=${31.897851}&longitude=${35.941489}&method=1&month=${DateTime.now().month}&year=${DateTime.now().year}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Utils.hideWaitingProgressDialog();
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        fajr = hourFormat
            .parse(jsonResponse["data"][DateTime.now().day - 1]['timings']
                    ['Fajr']
                .toString()
                .substring(0, 5))
            .add(Duration(minutes: iqamaTimes.fajr?? 30))
            .toString()
            .substring(11, 16);
        dhuhr = hourFormat
            .parse(jsonResponse["data"][DateTime.now().day - 1]['timings']
                    ['Dhuhr']
                .toString()
                .substring(0, 5))
            .add(Duration(minutes: iqamaTimes.dhuhr?? 15))
            .toString()
            .substring(11, 16);
        asr = hourFormat
            .parse(jsonResponse["data"][DateTime.now().day - 1]['timings']
                    ['Asr']
                .toString()
                .substring(0, 5))
            .add(Duration(minutes: iqamaTimes.asr?? 15))
            .toString()
            .substring(11, 16);
        maghrib = hourFormat
            .parse(jsonResponse["data"][DateTime.now().day - 1]['timings']
                    ['Maghrib']
                .toString()
                .substring(0, 5))
            .add(Duration(minutes: iqamaTimes.maghrib?? 5))
            .toString()
            .substring(11, 16);
        isha = hourFormat
            .parse(jsonResponse["data"][DateTime.now().day - 1]['timings']
                    ['Isha']
                .toString()
                .substring(0, 5))
            .add(Duration(minutes: iqamaTimes.isha?? 10))
            .toString()
            .substring(11, 16);
      });
    } else {
      // setState(() {
      //   showSpinner = false;
      // });
      var jsonResponse = jsonDecode(response.body);
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed: $jsonResponse.');

      showSnackBar(context, translate(context, 'somethingWentWrong'),
          translate(context, 'pleaseTryAgainLater'), "error");
    }
  }
}
