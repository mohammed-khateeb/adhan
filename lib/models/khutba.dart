import 'package:cloud_firestore/cloud_firestore.dart';

class Khutba {
  String? khateebName;
  Timestamp? date;
  String? dateString;



  Khutba(
      {
        this.khateebName,
        this.date,
        this.dateString,
      });

  Khutba.fromJson(Map<String, dynamic> json) {
    khateebName = json['khateeb_name'];
    date = json['date'];
    dateString = json['dateString'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['khateeb_name'] = khateebName;
    data['date'] = date;
    data['dateString'] = dateString;


    return data;
  }
}

