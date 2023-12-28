import 'package:demo_pizza/utils/image_view_360.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RotationController extends GetxController{

  RxList<ImageProvider> imageList = RxList<ImageProvider>([]);
  RxBool autoRotate = false.obs;
  RxInt rotationCount = 2.obs;
  RxInt swipeSensitivity = 2.obs;
  RxBool allowSwipeToRotate = true.obs;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 500);
  RxBool imagePrecached = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit

    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(Get.context!));
    super.onInit();
  }

  // void updateImageList(BuildContext context) async {
  //   for (int i = 0; i <= 99; i++) {
  //     if(i<=9){
  //       imageList.add(AssetImage('assets/cars2/000$i.png'));
  //       //* To precache images so that when required they are loaded faster.
  //       await precacheImage(AssetImage('assets/cars2/000$i.png'), context);
  //     }else{
  //       imageList.add(AssetImage('assets/cars2/00$i.png'));
  //       //* To precache images so that when required they are loaded faster.
  //       await precacheImage(AssetImage('assets/cars2/00$i.png'), context);
  //     }
  //
  //   }
  //     imagePrecached.value = true;
  // }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 52; i++) {
      imageList.add(AssetImage('assets/cars/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/cars/$i.png'), context);
    }
    imagePrecached.value = true;
  }


}