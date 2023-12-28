import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AnimatedControllerDrawer extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController ;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    update();
  }

   buttonToggle() => animationController!.isDismissed
      ? animationController?.forward()
      : animationController?.reverse();
}
