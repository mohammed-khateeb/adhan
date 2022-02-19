import 'package:flutter/cupertino.dart';

class Extension<T>{

  static String getObjectName({required BuildContext context, required String name}){
    List<String> names = name.split(",");
    for (var element in names) {
      if(Localizations.localeOf(context).languageCode=="en"&&element.contains('"en"')){
        List<String> nameEn = element.split(":");
        return nameEn[1].replaceAll('"', "").replaceAll("{", "").replaceAll("}", "");
      }
      else if(element.contains('"ar"')){
        List<String> nameAr = element.split(":");
        return nameAr[1].replaceAll('"', "").replaceAll("{", "").replaceAll("}", "");
      }

    }
    return "";

  }


}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}