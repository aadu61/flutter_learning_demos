import 'package:demo_pizza/controller/rotation_controller.dart';
import 'package:demo_pizza/utils/image_view_360.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RotationImage extends StatelessWidget {
  const RotationImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RotationController>(
      init: RotationController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("3d Rotation Image "),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 72.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (controller.imagePrecached.value == true)
                        ? ImageView360(
                            key: UniqueKey(),
                            imageList: controller.imageList.value,
                            autoRotate: controller.autoRotate.value,
                            rotationCount: controller.rotationCount.value,
                            rotationDirection: RotationDirection.anticlockwise,
                            frameChangeDuration: const Duration(milliseconds: 60),
                            swipeSensitivity: controller.swipeSensitivity.value,
                            allowSwipeToRotate:
                                controller.allowSwipeToRotate.value,
                            onImageIndexChanged: (currentImageIndex) {

                            },
                          )
                        : const Text("Pre-Caching images..."),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Optional features:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Auto rotate"),
                          Switch(value: controller.autoRotate.value, onChanged: (value){
                            controller.autoRotate.value = value;


                          })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:
                          Text("Rotation count: ${controller.rotationCount}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Rotation direction: ${controller.rotationDirection}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Frame change duration: ${controller.frameChangeDuration.inMilliseconds} milliseconds"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Allow swipe to rotate image: ${controller.allowSwipeToRotate}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Swipe sensitivity: ${controller.swipeSensitivity}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
