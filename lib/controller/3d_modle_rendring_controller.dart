import 'dart:developer';

import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

class ModleRendringController extends GetxController{


  Rxn<O3DController> controller = Rxn<O3DController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    controller.value = O3DController();

    Future.delayed(const Duration(seconds: 5),()=>{
    walk()
    });

  }


  void walk() async {
    // List<String>? availableAnimations = await controller.value?.availableAnimations();
    log("Available animations: ${await controller.value?.availableAnimations()}");

  }
}