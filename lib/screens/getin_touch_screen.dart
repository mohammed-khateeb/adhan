import 'package:adhan/component/slider.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/dialog/type_number_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetinTouchScreen extends StatelessWidget {
  const GetinTouchScreen({Key? key}) : super(key: key);

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
                  "GET IN TOUCH",
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
                    children: [
                      Container(
                        height: size.height*0.1,
                        width: size.width*0.7,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(size.height*0.03),
                        ),
                        child: Center(
                          child: Text(
                            "Subscribe to newsletter \n(type email)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.height*0.025,
                                color:kPrimaryColor
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height*0.03,),
                      InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => TypeNumberDialog(),
                          );
                        },
                        child: Container(
                          height: size.height*0.1,
                          width: size.width*0.7,
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(size.height*0.03),
                          ),
                          child: Center(
                            child: Text(
                              "Send me whatsapp group link \n(type number)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.height*0.025,
                                  color:kPrimaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height*0.03,),
                      Container(
                        height: size.height*0.1,
                        width: size.width*0.7,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(size.height*0.03),
                        ),
                        child: Center(
                          child: Text(
                            "Contact us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.height*0.025,
                                color:kPrimaryColor
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height*0.07,),
                      Icon(FontAwesomeIcons.facebook,size: size.height*0.055,color: Colors.white,),
                      SizedBox(height: size.height*0.01,),
                      Text(
                        "Madison Masjid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.height*0.025,
                            color:Colors.white
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
