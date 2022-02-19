import 'package:adhan/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SpinKitWave(
      color: kPrimaryColor,
      size: size.height*0.07,
      duration: const Duration(milliseconds: 900),
    );
  }
}