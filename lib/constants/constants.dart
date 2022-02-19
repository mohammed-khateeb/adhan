import 'package:flutter/material.dart';

const kTextFormFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(
    16.0,
  ),
  border: OutlineInputBorder(),
  labelText: 'Email',
  hintText: 'Enter your Email',
);

const kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
class CollectionsKey {

  static const appInfo = "AppInfo";
  static const khutba = "khutba";
  static const iqamaTimes = "Iqama_times";
  static const sliders = "sliders";
  static const user = "User";
  static const phone = "Phones";
  static const rent = "Rent";
  static const rentedCars = "Rented Cars";


}

class TopicKey{
  static const customers = "customers";
  static const exhibitions = "exhibitions";
  static const allUsers = "allUsers";
  static const admins = "admins";
}

class DocumentsKey{

  static const versions = CollectionsKey.appInfo + "/Versions";


}

const Color kPrimaryColor = Color(0xff256D49);
const Color kSecondaryColor = Color(0xffDB9227);
const Color kTertiaryColor = Color(0xffE8E8E8);
const Color kBackgroundColor = Color(0xffffffff);
const Color kRedColor = Color(0xffff5252);
const Color kGradientLeftColor = Color(0xffF7DC78);
const Color kGradientCenterColor = Color(0xfffec808);
const Color kGradientRightColor = Color(0xff9E7E0B);

