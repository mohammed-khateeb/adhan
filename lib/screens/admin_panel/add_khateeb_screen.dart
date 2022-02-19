import 'dart:io';

import 'package:adhan/Utils/util.dart';
import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/constants/constants.dart';
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
            color: kPrimaryColor,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Khateeb name",
                ),
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: dateController,
                readOnly: true,
                onTap: ()=>_selectDate(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Khutba date",
                ),
              ),
            ),
            SizedBox(height: size.height*0.02,),
            InkWell(
              onTap: () => add(context),
              child: Container(
                height: size.height*0.04,
                width: size.width*0.3,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(size.height*0.02),
                ),
                child: Center(
                  child: Text("Add",
                    style: TextStyle(fontSize: size.height*0.02,color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2200));
    if (picked != null){
      dateController.text = "${picked.month} - ${picked.day}";
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

    Utils.hideWaitingProgressDialog();

    Navigator.pop(context,khutba);
  }
}
