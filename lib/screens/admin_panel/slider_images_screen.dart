import 'package:adhan/Utils/util.dart';
import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/models/khutba.dart';
import 'package:adhan/models/slider.dart';
import 'package:adhan/screens/admin_panel/add_khateeb_screen.dart';
import 'package:adhan/widget/waiting_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SliderImagesScreen extends StatefulWidget {
  const SliderImagesScreen({Key? key,}) : super(key: key);

  @override
  _SliderImagesScreenState createState() => _SliderImagesScreenState();
}

class _SliderImagesScreenState extends State<SliderImagesScreen> {
  List<SliderImage>? sliders;
  SliderImage newSlider = SliderImage();
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      getSliders();
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
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  child: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                    size: size.height * 0.03,
                  ),
                  onPressed: () {
                    _showBottomSheet(context: context);
                  },
                ),
            ],
          ),
        ),
        body:sliders!=null? Column(
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
                  "Slider images",
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
                      itemCount: sliders!.length,
                      itemBuilder: (_,index){
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.02),
                          child: Container(
                            height: size.height*0.3,
                            width: size.width*0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size.height*0.05),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: NetworkImage(
                                  sliders![index].url!,
                                ),
                                fit: BoxFit.cover
                              )
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                iconSize: size.height*0.05,
                                color: kSecondaryColor,
                                onPressed: (){
                                  KhutbaApi.deleteSlider(sliders![index]);
                                  setState(() {

                                  });
                                  sliders!.removeWhere((element) => element.id == sliders![index].id);
                                },
                              ),
                            ),
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

  getSliders() async {
    await KhutbaApi.getSliders().then((value) {
      setState(() {
        sliders = value;
      });
    });
  }

  addSlider() async {
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
       // sliders.add();
      }

    }
  }
  _showBottomSheet({required BuildContext context}) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  onTap: () async {
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      Utils.showWaitingProgressDialog();
                      String url = await KhutbaApi.saveOneImage(
                          xFile:image, folderPath: 'slider-images');
                      newSlider.url = url;
                      newSlider.date = Timestamp.fromDate(DateTime.now());
                      await KhutbaApi.addNewSlider(sliderImage: newSlider);
                      Utils.hideWaitingProgressDialog();
                      setState(() {
                        sliders!.add(newSlider);
                      });
                      Navigator.pop(context);
                    }
                  },
                  title: Text(translate(context, "gallery")),
                  leading: Icon(Icons.image),
                ),
                ListTile(
                  onTap: () async {
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {

                      Navigator.pop(context);
                    }
                  },
                  title: Text("Camera"),
                  leading: Icon(Icons.camera),
                )
              ],
            ),
          );
        });
  }
}
