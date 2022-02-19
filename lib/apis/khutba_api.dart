import 'package:cloud_firestore/cloud_firestore.dart';

class KhutbaApi{

  static FirebaseFirestore db = FirebaseFirestore.instance;



  static Future<void> addNewKhutba({required dynamic khutba}) async {

    DocumentReference doc = db.collection("khutbas").doc();

    await doc.set(khutba);


  }



  // static void deleteAnimal(
  //     String animalId)  {
  //   DocumentReference userDoc =
  //   db.collection(CollectionsKey.exhibition).doc(animalId);
  //
  //   userDoc.delete();
  //
  //   return ;
  // }
  //
  //
  //
  static Future<List<dynamic>> getKhutbas() async {
    List<dynamic> khutbas = [];

    QuerySnapshot snapshot = await db
        .collection("khutbas")
        .get();

    khutbas = snapshot.docs.toList();

    return khutbas;
  }






}

