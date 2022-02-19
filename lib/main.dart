import 'dart:io';
import 'package:adhan/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Localizations/app_language.dart';
import 'Localizations/app_localization.dart';
import 'Utils/util.dart';
import 'constants/constants.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  if (Platform.isIOS) FirebaseMessaging.instance.requestPermission();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: true,
  );



  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
      MyApp(appLanguage: appLanguage)
  );
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  const MyApp({key, required this.appLanguage}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {



  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance!.addObserver(this);

    var initializationSettingsAndroid =
    const AndroidInitializationSettings("logo");

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,iOS: const IOSInitializationSettings()
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification?.body);
      RemoteNotification? notification = event.notification;
      AndroidNotification? androidNotification = event.notification?.android;
      if (notification != null && androidNotification != null) {
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'channel_ID', 'channel name', 'channel description',
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
          fullScreenIntent: true,

          //indeterminate: true,
          timeoutAfter: 5000,
          color: kPrimaryColor,
          //color: Colors.red,
          icon: "logo",
        );
        flutterLocalNotificationsPlugin.show(
            event.notification.hashCode,
            event.notification!.title,
            event.notification!.body,
            NotificationDetails(
              android: androidPlatformChannelSpecifics,
            ),
            payload: 'test');
      }
    });
  }




  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => widget.appLanguage,
      child: Consumer<AppLanguage>(builder: (context,model, child) {
        return  MaterialApp(
          navigatorKey: Utils.navKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                    color: Colors.black
                )
            ),
            focusColor: Colors.black26,///For Shimmer

            primaryColor: Colors.white,
            iconTheme: IconThemeData(
                color: Colors.grey[800]
            ),

            brightness: Brightness.light,
            fontFamily: "Futura_Bold",
            /* light theme settings */
          ),


          locale: model.appLocal,
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates: const[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),

          },
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
