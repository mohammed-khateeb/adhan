
import 'package:adhan/Utils/util.dart';
import 'package:adhan/component/slider.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/screens/getin_touch_screen.dart';
import 'package:adhan/screens/khutba_schedule.dart';
import 'package:adhan/screens/iqama_time_screen.dart';
import 'package:adhan/screens/payer_time_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.05,),
            Image.asset("images/logo.png",height: size.height*0.06,width: size.width,),
            SizedBox(height: size.height*0.02,),
            BuildSlider(),
            SizedBox(height: size.height*0.03,),
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
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 0;
                          });
                          openNewPage(context, const PayerTimeScreen());
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
                              "Payer Times",
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
                              "Khutba Schedule",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 2? Colors.white:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 3;
                          });
                          openNewPage(context, const GetinTouchScreen());
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
                            color:selectedIndex == 3? kSecondaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.2),
                          ),
                          child: Center(
                            child: Text(
                              "Get In Touch",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 3? Colors.white:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 4;
                          });
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
                            color:selectedIndex == 4? kSecondaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.2),
                          ),
                          child: Center(
                            child: Text(
                              "Donation",
                              style: TextStyle(
                                  fontSize: size.height*0.03,
                                  color:selectedIndex == 4? Colors.white:kPrimaryColor
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
