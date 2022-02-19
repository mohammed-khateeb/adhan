
import 'package:adhan/Utils/util.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/screens/khutba_schedule.dart';
import 'package:adhan/screens/iqama_time_screen.dart';
import 'package:flutter/material.dart';

import 'khutba_schedule.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex = -1;
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
            color: kPrimaryColor,
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
                  "Admin Panel",
                  style: TextStyle(
                      fontSize: size.height*0.03,
                      color:Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.05,),
            Image.asset("images/logo.png",height: size.height*0.1,width: size.width,),
            SizedBox(height: size.height*0.1,),
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
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 0;
                          });
                          openNewPage(context, const KhutbaSchedule());
                        },
                        child: Container(
                          height: size.height*0.062,
                          width: size.width*0.72,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                                offset: const Offset(
                                    1, 7), // changes position of shadow
                              ),
                            ],
                            color:selectedIndex == 0? kSecondaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.2),
                          ),
                          child: Center(
                            child: Text(
                              "Khutba Schedule",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 0? Colors.white:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 1;
                          });
                          openNewPage(context, const IqamaTimeScreen());
                        },
                        child: Container(
                          height: size.height*0.062,
                          width: size.width*0.72,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                                offset: const Offset(
                                    1, 7), // changes position of shadow
                              ),
                            ],
                            color:selectedIndex == 1? kSecondaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.2),
                          ),
                          child: Center(
                            child: Text(
                              "Iqamah Times",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 1? Colors.white:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 2;
                          });
                          openNewPage(context, const KhutbaScheduleScreen());
                        },
                        child: Container(
                          height: size.height*0.062,
                          width: size.width*0.72,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                                offset: const Offset(
                                    1, 7), // changes position of shadow
                              ),
                            ],
                            color:selectedIndex == 2? kSecondaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.2),
                          ),
                          child: Center(
                            child: Text(
                              "Whatsapp group numbers",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 2? Colors.white:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
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
}
