import 'dart:convert';

import 'package:adhan/Utils/util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationServices {
  static String? fcmToken;

  static final flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo');

    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    return Future<void>.value();
  }

  static showNotification(String title, String message) async {
    AndroidNotificationDetails _androidNotificationDetails =
    const AndroidNotificationDetails(
      'channel ID',
      'channel name',
      'channel des',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,

    );

    IOSNotificationDetails _iosNotificationDetails =
    const IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1);

    var platform = NotificationDetails(
        android: _androidNotificationDetails, iOS: _iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platform,
      payload: 'PushNotification Payload',
    );
  }
  static void sendMessageToTopic({required String title,required String body,required String topicName}) async {
    String fcmServerKey = "AAAAfD0PhIk:APA91bFdwreMZs9b9LLPo9kxi3eiLQZ0S_NGKpC7v6eln8-QBPssAyja5SdKpUd1FSOcVyFuF_knvzwJbhitJkwbyBsnqNMhfb-xamfXqglLEzNCYUPC1PesT5MdcQ8IZGISrpxnoCEK";
    Utils.showWaitingProgressDialog();
    await http.post( Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$fcmServerKey'
        },
        body: jsonEncode({
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'sound': 'true'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/$topicName"
        })).whenComplete(() {
      Utils.hideWaitingProgressDialog();

    }).catchError((e) {
      debugPrint('error: $e');
    });
  }
  static void sendMessageToAnyUser({required String title,required String body,required String to}) async {
    String fcmServerKey = "AAAAfD0PhIk:APA91bFdwreMZs9b9LLPo9kxi3eiLQZ0S_NGKpC7v6eln8-QBPssAyja5SdKpUd1FSOcVyFuF_knvzwJbhitJkwbyBsnqNMhfb-xamfXqglLEzNCYUPC1PesT5MdcQ8IZGISrpxnoCEK";
    Utils.showWaitingProgressDialog();
    await http.post( Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$fcmServerKey'
        },
        body: jsonEncode({
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'sound': 'true'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': to
        })).whenComplete(() {
      Utils.hideWaitingProgressDialog();
    }).catchError((e) {
      debugPrint('error: $e');
    });
  }
}