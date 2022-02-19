import 'dart:ui';

import 'package:adhan/Utils/util.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/dialog/thanks_dialog.dart';
import 'package:adhan/screens/admin_panel/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io' show Platform, exit;

class TypeNumberDialog extends StatefulWidget {
  const TypeNumberDialog({Key? key}) : super(key: key);

  @override
  State<TypeNumberDialog> createState() => _TypeNumberDialogState();
}

class _TypeNumberDialogState extends State<TypeNumberDialog> with SingleTickerProviderStateMixin{

  AnimationController? controller;
  Animation<double>? scaleAnimation;
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScaleTransition(
      scale: scaleAnimation!,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 1.5,
            sigmaY: 1.5
        ),
        child: AlertDialog(
          elevation: 0,

          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width*0.5,
            child: Container(
              height: size.height*0.25,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4.0,
                      spreadRadius: 3,
                      offset: Offset(0.0, 1)
                  )
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(size.height*0.06),bottom: Radius.circular(size.height*0.02)),
                color: Colors.white,
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width*0.06),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.03,),

                    Container(
                      child: Text("Send for you \nwhatsapp group link",
                        style: TextStyle(fontSize: size.height*0.025,color: kPrimaryColor),
                        textAlign: TextAlign.center,

                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: size.height*0.03,),
                    TextField(
                      autofocus: false,
                      controller: numberController,
                      style: TextStyle(fontSize: size.height*0.016),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Type your number ..',

                        contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0,right: 14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.02,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        if(numberController.text == "0000"){
                          openNewPage(context, const AdminHomeScreen());
                        }
                        else{
                          showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => const ThanksDialog(),
                          );
                        }

                      },
                      child: Container(
                        height: size.height*0.04,
                        width:  size.height*0.12,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                size.height*0.03
                            )
                        ),
                        child: Center(
                          child: Text(
                            "Request",
                            style: TextStyle(
                                fontSize: size.height*0.02,
                                color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.01,)
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
