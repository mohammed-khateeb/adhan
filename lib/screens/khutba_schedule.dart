
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class KhutbaScheduleScreen extends StatefulWidget {
  const KhutbaScheduleScreen({Key? key}) : super(key: key);

  @override
  _KhutbaScheduleScreenState createState() => _KhutbaScheduleScreenState();
}

class _KhutbaScheduleScreenState extends State<KhutbaScheduleScreen> {
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
                  "Khutba Schedule",
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
                  image: const DecorationImage(
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
                                "Dr. Gadallah",
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
                                "Dr. Gadallah",
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
                                "Dr. Gadallah",
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
                                "Dr. Gadallah",
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
                                "Dr. Gadallah",
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
}
