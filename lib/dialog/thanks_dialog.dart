import 'dart:ui';

import 'package:adhan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ThanksDialog extends StatefulWidget {
  const ThanksDialog({Key? key}) : super(key: key);

  @override
  State<ThanksDialog> createState() => _ThanksDialogState();
}

class _ThanksDialogState extends State<ThanksDialog> with SingleTickerProviderStateMixin{

  AnimationController? controller;
  Animation<double>? scaleAnimation;

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      child: Text("Thank you",
                        style: TextStyle(fontSize: size.height*0.025,color: kPrimaryColor),
                        textAlign: TextAlign.center,

                        maxLines: 3,
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
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
                            "ok!",
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
