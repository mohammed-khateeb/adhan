import 'package:cloud_firestore/cloud_firestore.dart';

class IqamaTimes {
  int? fajr;
  int? dhuhr;
  int? asr;
  int? maghrib;
  int? isha;



  IqamaTimes(
      {
        this.fajr,
        this.dhuhr,
        this.asr,
        this.maghrib,
        this.isha
      });

  IqamaTimes.fromJson(Map<String, dynamic> json) {
    fajr = json['fajr'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    maghrib = json['maghrib'];
    isha = json['isha'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fajr'] = fajr ?? 30;
    data['dhuhr'] = dhuhr ?? 15;
    data['asr'] = asr?? 15;
    data['maghrib'] = maghrib ??5;
    data['isha'] = isha??10;

    return data;
  }
}

