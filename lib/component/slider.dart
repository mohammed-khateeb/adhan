import 'package:adhan/apis/khutba_api.dart';
import 'package:adhan/constants/constants.dart';
import 'package:adhan/models/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class BuildSlider extends StatefulWidget {
  final Color? paginationColor;
  const BuildSlider({Key? key,this.paginationColor}): super(key: key);

  @override
  State<BuildSlider> createState() => _BuildSliderState();
}

class _BuildSliderState extends State<BuildSlider> {

  List<SliderImage>? sliders;
  @override
  void initState() {
    KhutbaApi.getSliders().then((value) {
      setState(() {
        sliders = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return sliders!=null?SizedBox(
      height: size.height*0.26,
      child: Swiper(
        outer: true,
        autoplay: true,
        viewportFraction: 1,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal:size.height*0.01,),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    size.height * 0.04
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: const Offset(
                        1, 7), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    image: NetworkImage(sliders![index].url!),
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
        pagination: SwiperPagination(builder:
        SwiperCustomPagination(builder:
            (BuildContext context, SwiperPluginConfig config) {
          return SizedBox(
              width: size.width,
              height: size.height * 0.01,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sliders!.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: config.activeIndex == index
                              ? BorderRadius.circular(
                              size.height * 0.02)
                              : null,
                          color:  widget.paginationColor??kPrimaryColor,
                          shape: config.activeIndex != index
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                        ),
                        width: config.activeIndex == index
                            ? size.height * 0.02
                            : size.height * 0.0125,
                      ),
                    );
                  },
                ),
              ));
        })),

        itemCount: sliders!.length,
      ),
    ):SizedBox();
  }
}
