import 'package:adhan/Utils/util.dart';
import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/models/khutba.dart';
import 'package:adhan/screens/admin_panel/add_khateeb_screen.dart';
import 'package:adhan/widget/waiting_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KhutbaScheduleScreen extends StatefulWidget {
  final bool isAdmin;
  const KhutbaScheduleScreen({Key? key, this.isAdmin = false}) : super(key: key);

  @override
  _KhutbaScheduleScreenState createState() => _KhutbaScheduleScreenState();
}

class _KhutbaScheduleScreenState extends State<KhutbaScheduleScreen> {
  List<Khutba>? khutbas;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      getKhutbas();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                  size: size.height * 0.03,
                ),
              ),
              if(widget.isAdmin)
              FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 0,
                child: Icon(
                  Icons.add,
                  color: kPrimaryColor,
                  size: size.height * 0.03,
                ),
                onPressed: () {
                  addKhateeb();
                },
              ),
            ],
          ),
        ),
        body:khutbas!=null? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.05,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: const Offset(1, 7), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(size.height * 0.02)),
              ),
              child: Center(
                child: Text(
                  "Khutba Schedule",
                  style: TextStyle(
                      fontSize: size.height * 0.03, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(size.height * 0.06)),
                  image: const DecorationImage(
                      image: AssetImage("images/custom-shape.png"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.06),
                    child: ListView.builder(
                      itemCount: khutbas!.length,
                      itemBuilder: (_,index){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.23,
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                                ),
                                child: Center(
                                  child: Text(
                                    khutbas![index].dateString!,
                                    style: TextStyle(
                                        fontSize: size.height * 0.02,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(size.height * 0.015),
                                ),
                                child: Center(
                                  child: Text(
                                    khutbas![index].khateebName!,
                                    style: TextStyle(
                                        fontSize: size.height * 0.02,
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                ),
              ),
            ),
          ],
        ):WaitingWidget(),
      ),
    );
  }

  getKhutbas() async {
    await KhutbaApi.getKhutbas().then((value) {
      setState(() {
        khutbas = value;
      });
    });
  }

  addKhateeb() async {
    dynamic result = await openNewPage(context, const AddKhateebScreen());

    if (result is List<String>) {

      Khutba khutba = Khutba();
      khutba.khateebName = result[0];
      khutba.dateString = result[1];
      khutba.date = Timestamp.fromDate(DateTime.parse(result[2]));


      Utils.showWaitingProgressDialog();

      KhutbaApi.addNewKhutba(khutba: khutba);

      Utils.hideWaitingProgressDialog();

      if(mounted) {
        getKhutbas();
      }

    }
  }
}
