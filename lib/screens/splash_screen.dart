import 'dart:async';
import 'package:adhan/Utils/util.dart';
import 'package:adhan/push_notification/push_notification_serveice.dart';
import 'package:adhan/screens/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool newUpdate = false;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;


  String? fcmToken;



  @override
  void initState() {
    super.initState();


    PushNotificationServices.initLocalNotification();

    initFirebaseMessaging();

    startSplashScreenTimer();

  }



  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, openHome);
  }




  void openHome() async {


      openNewPage(context, const HomeScreen(),popPreviousPages: true);

  }




  void initFirebaseMessaging() async {
    _messaging.getToken().then((token) {
      fcmToken = token;



      PushNotificationServices.fcmToken = fcmToken;

    });

    _messaging.onTokenRefresh.listen((newToken) {
      PushNotificationServices.fcmToken = fcmToken;
    });

    FirebaseMessaging.onBackgroundMessage(
        PushNotificationServices.firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotificationServices.showNotification(
          message.notification!.title!, message.notification!.body!);
    });

  }



  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return  Scaffold(
            body: Hero(
              tag: "logo",
              child: Center(
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(
                              "images/back.png"
                          ),fit: BoxFit.fill
                      ),
                    ),
                  child: Center(
                    child: Image.asset(
                      "images/splash_logo.png",
                      height: size.height*0.13,
                      width: size.width,
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
