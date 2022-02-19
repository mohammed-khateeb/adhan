import 'dart:io';

import 'package:adhan/Utils/util.dart';
import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddKhateebScreen extends StatefulWidget {
  const AddKhateebScreen({Key? key}) : super(key: key);

  @override
  State<AddKhateebScreen> createState() => _AddKhateebScreenState();
}

class _AddKhateebScreenState extends State<AddKhateebScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? date;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color:  Colors.white,
            size: size.height*0.03,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: size.height*0.05,
              width: size.width*0.6,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: const Offset(
                        1, 7), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(size.height*0.02)
                ),
              ),
              child: Center(
                child: Text(
                  "Add Khutba",
                  style: TextStyle(
                      fontSize: size.height*0.03,
                      color:Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.2,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(size.height * 0.06)),
                  image: const DecorationImage(
                      image: AssetImage("images/custom-shape.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.05,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                      child: TextField(
                        autofocus: false,
                        controller: nameController,
                        style: TextStyle(fontSize: size.height*0.016),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Khateeb name',

                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0,right: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height*0.02,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                      child: TextField(
                        autofocus: false,
                        controller: dateController,
                        readOnly: true,
                        onTap: ()=>_selectDate(context),
                        style: TextStyle(fontSize: size.height*0.016),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Khutba date',

                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0,right: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.05,),
                    InkWell(
                      onTap: () => add(context),
                      child: Container(
                        height: size.height*0.04,
                        width: size.width*0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(size.height*0.02),
                        ),
                        child: Center(
                          child: Text("Add",
                            style: TextStyle(fontSize: size.height*0.02,color: kPrimaryColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  String sanitizeDateTime(DateTime dateTime) => "${dateTime.year}-${dateTime.month}-${dateTime.day}";

  Set<String> getDateSet(List<DateTime> dates) => dates.map(sanitizeDateTime).toSet();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2200));

    if (picked != null){
      if(picked.weekday != 5){
        Utils.showErrorAlertDialog("this day is not friday");
        return;
      }
      dateController.text = "${picked.month} - ${picked.day}";
      date = picked.toString();
    }
  }



  Future<void> add(BuildContext context) async {

    if(nameController.text.trim().isEmpty||dateController.text.trim().isEmpty) {
      return;
    }

    Utils.showWaitingProgressDialog();

    List<String> khutba = [];
    khutba.add(nameController.text);
    khutba.add(dateController.text);
    khutba.add(date!);

    Utils.hideWaitingProgressDialog();

    Navigator.pop(context,khutba);
  }
}
