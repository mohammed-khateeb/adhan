// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
//
// import 'extensions.dart';
//
// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
//
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }
//
// class Constant {
//   static const String USERS_REF = "Users";
//   static const String _INFO_PAGE_REF = "InfoPage/";
//   static const String _USER_FILES_REF = "UserFiles/";
//   static const String _VIDEOS_REF = "Videos/";
//
//   //for track user is sign
//   static const String USERS_TRACKER_REF = "UsersTracker";
//
//   static const String VERSIONS_REF = "Versions";
//
//
//   static const String SERVICES_REF = "Services";
//   static const String TEAM_MEMBERS_REF = "TeamMembers";
//
//   // path for firebase storage
//   static const String SERVICES_FOLDER_STORAGE = "ServicesImages";
//
//
//   static const String VIDEOS_CATEGORY_REF = _VIDEOS_REF +"Category";
//   static const String VIDEOS_CATEGORY_CONTENT_REF = _VIDEOS_REF +"CategoryContent/";
//
//   static const String ABOUT_CLINIC_TEXT_REF = _INFO_PAGE_REF + "About";
//   static const String IMAGE_SLIDER_REF = _INFO_PAGE_REF + "ImageSlider";
//   static const String TEAM_IMG_REF = _INFO_PAGE_REF + "teamImage";
//
//
//   static const String _BOOKING_DATE_REF = "BookingDate/";
//   static const String BOOKING_REF = _BOOKING_DATE_REF + "Bookings";
//   static const String REFERENCE_BOOKING_NUMBER_REF =
//       _BOOKING_DATE_REF + "CurrentReferenceNum";
//
//   static const String MEDICAL_STATUS_REF =
//       _USER_FILES_REF + "MedicalStatus";
//
//   static const String DOCTOR_DIAGNOSIS_REF =
//       _USER_FILES_REF + "DoctorDiagnosis";
//
// }
//
// String removeDecimalZeroFormat(double n) {
//   return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
// }
//
// Future storeUserIntoPref(UserApp user) async {
//   if (user == null) return;
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
// //  userGlobal = user;
//
//   Map userMap = user.toJson();
//
//   String userJson = json.encode(userMap);
//
//   prefs.setString('User_Pref', userJson);
// }
//
// Future<bool> isNotificationEnable() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   bool enable = prefs.getBool("isNotificationEnable");
//
//   return enable ?? true;
// }
//
// Future switchNotificationEnable(bool state) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   prefs.setBool("isNotificationEnable", state);
//
//   return;
// }
//
// Future<UserApp> getUserFromPref() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   String jsonUser = prefs.getString('User_Pref');
//
//   if (jsonUser == null) {
//     User firebaseUser =  Auth.getCurrentUser();
//     if (firebaseUser == null) return null;
//
//     UserApp user = await Api.getUserFromUid(firebaseUser.uid);
//     storeUserIntoPref(user);
//
//     return user;
//   }
//
//   Map userMap = json.decode(jsonUser);
//
//   return UserApp.fromJson(userMap);
// }
//
// void sendEmail({@required String toMailId, String subject = "", String body = ""}) async {
//   var url = 'mailto:$toMailId?subject=$subject&body=$body';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//


//
// void launchWhatsApp(String phone) async {
//   var url = "https://wa.me/$phone?text=السلام عليكم ...لدي استفسار حول ";
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// ///main arrow back
// Widget getBackArrow(BuildContext context, {Color color}) => IconButton(
//       icon: Icon(
//         Icons.arrow_back_ios,
//       ),
//       color: color ?? Colors.white,
//       onPressed: () => Navigator.pop(context),
//     );
//
// /// blocks rotation; sets orientation to: portrait
// void portraitModeOnly() {
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
// }
//
import 'dart:convert';

import 'package:adhan/Localizations/app_localization.dart';
import 'package:adhan/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';



class Utils{

  static final navKey = GlobalKey<NavigatorState>();

  static SharedPreferences? preferences;


  static final SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
      context: navKey.currentState!.overlay!.context, barrierDimisable: false);








  static showWaitingProgressDialog() {
    _dialog.show(message: translate(navKey.currentState!.context, "please_wait"),indicatorColor: kPrimaryColor,backgroundColor: Colors.transparent);
  }

  static hideWaitingProgressDialog() {
    _dialog.hide();
  }

  static showSuccessAlertDialog(String msg,{IconData? iconData,String? label,Color? color,Widget? action,Function? onTap}) {
    AlertDialog alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              CircleAvatar(
                child: Icon(
                  iconData??Icons.done,
                  size: 80,
                  color: Colors.white,
                ),
                backgroundColor:color?? kPrimaryColor,
                radius: 55,
              ),
            ],
          ),
        ],
      ),
      content: Container(
        margin: EdgeInsetsDirectional.only(bottom: 0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label??translate(navKey.currentState!.context, 'success'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.60,
                  child: Center(
                    child: Text(
                      msg,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.45,
                  height: 40,
                  child:action?? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () {
                      Navigator.of(navKey.currentState!.context,
                          rootNavigator: true)
                          .pop('dialog');
                      if(onTap!=null) {
                        onTap();
                      }
                    },
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    child: Text(
                        translate(navKey.currentState!.context, "ok"),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: navKey.currentState!.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showExitAlertDialog(){
    AlertDialog alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  const [
              CircleAvatar(
                child: Icon(
                  Icons.info_outline,
                  size: 80,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
                radius: 55,
              ),
            ],
          ),
        ],
      ),
      content: Container(
        margin: EdgeInsetsDirectional.only(bottom: 0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.60,
                  child: Center(
                    child: Text(
                      translate(navKey.currentState!.context, "areYouSureToExit"),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.45,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: Text(
                            translate(navKey.currentState!.context, "exit"),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Navigator.of(navKey.currentState!.context,
                              rootNavigator: true)
                              .pop('dialog');
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: Text(
                            translate(navKey.currentState!.context, "cancel"),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: navKey.currentState!.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSureAlertDialog({required Function onSubmit}){
    AlertDialog alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  const [
              CircleAvatar(
                child: Icon(
                  Icons.info_outline,
                  size: 80,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
                radius: 55,
              ),
            ],
          ),
        ],
      ),
      content: Container(
        margin: EdgeInsetsDirectional.only(bottom: 0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.60,
                  child: Center(
                    child: Text(
                      translate(navKey.currentState!.context, "areYouSure"),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.45,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Navigator.of(navKey.currentState!.context,
                              rootNavigator: true)
                              .pop('dialog');
                          onSubmit();
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: Text(
                            translate(navKey.currentState!.context, "ok"),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Navigator.of(navKey.currentState!.context,
                              rootNavigator: true)
                              .pop('dialog');
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: Text(
                            translate(navKey.currentState!.context, "cancel"),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: navKey.currentState!.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future showErrorAlertDialog(String msg,{Function? whenNavBack}) async{
    AlertDialog alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                child: Icon(
                  Icons.close,
                  size: 80,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
                radius: 55,
              ),
            ],
          ),
        ],
      ),
      content: Container(
        margin: const EdgeInsetsDirectional.only(bottom: 0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translate(navKey.currentState!.context, 'error'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.60,
                  child: Center(
                    child: Text(
                      msg,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const  SizedBox(
                  height: 23,
                ),
                SizedBox(
                  width:
                  MediaQuery.of(navKey.currentState!.context).size.width *
                      0.45,
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () {
                      Navigator.of(navKey.currentState!.context,
                          rootNavigator: true)
                          .pop('dialog');

                    },
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    child: Text(
                        translate(navKey.currentState!.context, "ok"),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: navKey.currentState!.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);

  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? true;
  }
}

String getStringFromEnum(Object value) =>
    value
        .toString()
        .split('.')
        .last;

T enumValueFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == getStringFromEnum(v!));


Future<dynamic> openNewPage(BuildContext context, Widget widget,
    {bool popPreviousPages = false,bool replacement = false}) {
  if(replacement){
    return Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>  widget,
      ),
    );
  }
  else {
    if (!popPreviousPages) {
      return Navigator.push(context,PageTransition(type: PageTransitionType.fade, child: widget));
    } else {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => widget),
              (Route<dynamic> route) => false);
    }
  }
}
void showSnackBar(
    BuildContext context, String title, String desc, String type) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: type == "warning" ? Colors.amber : Colors.redAccent,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          desc,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        )
      ],
    ),
    action: SnackBarAction(
      label: translate(context,'ok'),
      onPressed: () {
        // Some code to undo the change.
      },
      textColor: Colors.white,
      disabledTextColor: Colors.grey,
    ),
  ));
}

void makeCall(String phone) {
  launch("tel://$phone");
}
// void openGoogleMap(double lat, double lng) async {
//   var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
//   if (await canLaunch(uri.toString())) {
//     await launch(uri.toString());
//   } else {
//     throw 'Could not launch ${uri.toString()}';
//   }
// }

String translate(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key)!;
}



// bool notValidPathFirebase(String path) {
//   //Firebase Database paths must not contain '.', '#', '$', '[', or ']'
//   return path.contains('.') ||
//       path.contains('#') ||
//       path.contains('\$') ||
//       path.contains('[') ||
//       path.contains(']');
// }
//
// Color colorFromHex(String hexColor) {
//   return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
// }
//
// /// the current time, in “seconds since the epoch”
// int currentTimeInSeconds() {
//   var ms = (new DateTime.now()).millisecondsSinceEpoch;
//   return (ms / 1000).round();
// }
//
Widget getCenterCircularProgress({double padding = 0, required double size}) {
  return Container(
    padding: EdgeInsets.all(padding),
    height: size,
    width: size,
    child: const Center(
      child: CircularProgressIndicator(backgroundColor: kPrimaryColor,),
    ),
  );
}
//
// Future<dynamic> showAlertDialog(
//     BuildContext context, String title, String des, AlertType type,
//     {Widget content,
//     Function closeFun,
//     Function positiveBtnFun,
//     String mainBtnText,
//     bool ableDismiss,
//     Color desColor,
//     double desFontSize}) {
//   return Alert(
//     context: context,
//     type: type,
//     style: AlertStyle(
//         descStyle: TextStyle(fontSize: desFontSize ?? 12, color: desColor),
//         isCloseButton: ableDismiss ?? true,
//         isOverlayTapDismiss: ableDismiss ?? true),
//     title: title,
//     desc: des,
//     content: content,
//     closeFunction: closeFun,
//     buttons: [
//       DialogButton(
//         child: Text(
//           mainBtnText ?? "حسنا",
//           style: TextStyle(color: Colors.black, fontSize: 20),
//         ),
//         onPressed: () {
//           if (positiveBtnFun != null)
//             {Navigator.pop(context);
//             positiveBtnFun.call();}
//           else
//             Navigator.pop(context);
//
//
//         },
//         width: 120,
//       )
//     ],
//   ).show();
// }
//
// String getStringFromEnum(Object value) => value?.toString()?.split('.')?.last ?? "";
//
// T enumValueFromString<T>(String key, List<T> values,{T orElse}) =>
//     values.firstWhere((v) => key == getStringFromEnum(v), orElse: () => orElse);
//
// //util method
// void showToast(BuildContext context, String text) {
//   Toast.show(text, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
// }
//
// bool isEmail(String em) {
//   String p =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//
//   RegExp regExp = new RegExp(p);
//
//   return regExp.hasMatch(em);
// }
//
// ProgressDialog getProgressDialog(BuildContext context,
//     {ProgressDialogType type}) {
//   return ProgressDialog(context,
//       type: type ?? ProgressDialogType.Normal,
//       isDismissible: false,
//       showLogs: false);
// }
//

String getStringFromDateTime({required DateTime time}){
  return "${time.year}-${time.month}-${time.day}";
}

// int getDiffInDay(DateTime date) {
//   return date.difference(DateTime.now()).inDays;
// }
//
String formatDate(DateTime date, {DateFormat? formatter}) {
  formatter ??= DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);

  return formatted;
}
//
// Map<String, dynamic> listToIndexMap(List<dynamic> list) {
//   Map<String, dynamic> map = Map();
//
//   for (int i = 0; i < list.length; i++) map["$i"] = list[i];
//
//   return map;
// }
//
// void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey,String title,{bool isError = false}){
//   scaffoldKey?.currentState?.showSnackBar( SnackBar(content: new Text(title),backgroundColor: isError ? Colors.red[900] : null,));
// }