import 'package:cloud_firestore/cloud_firestore.dart';

class SliderImage{
  String? id;
  Timestamp? date;
  String? url;



  SliderImage(
      {
        this.id,
        this.date,
        this.url,
      });

  SliderImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    url = json['url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['url'] = url;


    return data;
  }
}

