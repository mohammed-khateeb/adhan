import 'dart:io';

import 'package:adhan/constants/constants.dart';
import 'package:adhan/models/iqama_times.dart';
import 'package:adhan/models/khutba.dart';
import 'package:adhan/models/slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class KhutbaApi{

  static FirebaseFirestore db = FirebaseFirestore.instance;



  static Future<Khutba> addNewKhutba({required Khutba khutba}) async {

    DocumentReference doc = db.collection(CollectionsKey.khutba).doc(khutba.date.toString());


    await doc.set(khutba.toJson());


    return khutba;
  }

  static Future<IqamaTimes> addNewIqamaTimes({required IqamaTimes iqamaTimes}) async {

    DocumentReference doc = db.collection(CollectionsKey.iqamaTimes).doc(CollectionsKey.iqamaTimes);


    await doc.set(iqamaTimes.toJson());


    return iqamaTimes;
  }

  static Future<void> addNewPhones({required String phone}) async {

    DocumentReference doc = db.collection(CollectionsKey.phone).doc();

    await doc.set({"phone" : phone});

  }
  static Future<List<dynamic>> getPhones() async {
    List<dynamic> phones = [];

    QuerySnapshot snapshot = await db
        .collection(CollectionsKey.phone)
        .get();

    phones = snapshot.docs.toList() ;

    return phones;
  }


  static void deleteSlider(
      SliderImage sliderImage)  {
    DocumentReference doc =
    db.collection(CollectionsKey.sliders).doc(sliderImage.id);

    doc.delete();

    return ;
  }



  static Future<List<Khutba>> getKhutbas() async {
    List<Khutba> khutbas = [];

    QuerySnapshot snapshot = await db
        .collection(CollectionsKey.khutba)
        .where("date",isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .get();

    khutbas = snapshot.docs.map((e) => Khutba.fromJson(e.data() as Map<String, dynamic>)).toList() ;

    return khutbas;
  }

  static Future<SliderImage> addNewSlider({required SliderImage sliderImage}) async {

    DocumentReference doc = db.collection(CollectionsKey.sliders).doc();

    sliderImage.id = doc.id;


    await doc.set(sliderImage.toJson());


    return sliderImage;
  }


  static Future<List<SliderImage>> getSliders() async {
    List<SliderImage> sliders = [];

    QuerySnapshot snapshot = await db
        .collection(CollectionsKey.sliders)
        .get();

    sliders = snapshot.docs.map((e) => SliderImage.fromJson(e.data() as Map<String, dynamic>)).toList() ;

    return sliders;
  }

  static Future<IqamaTimes?> getIqamaTimes() async {

     DocumentSnapshot documentSnapshot = await db
        .collection(CollectionsKey.iqamaTimes)
        .doc(CollectionsKey.iqamaTimes)
        .get();

    IqamaTimes iqamaTimes = IqamaTimes.fromJson(documentSnapshot.data() as Map<String,dynamic>);

    return iqamaTimes;

  }
  static Future <dynamic> saveOneImage(
      {required XFile xFile,required String folderPath}) async {
    await FirebaseAuth.instance.signInAnonymously();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
    FirebaseStorage.instance.ref().child(folderPath).child(fileName);
    TaskSnapshot uploadTask = await reference.putFile(File(xFile.path));
    String url = await uploadTask.ref.getDownloadURL();
    print(url);
    return url;
  }





}

