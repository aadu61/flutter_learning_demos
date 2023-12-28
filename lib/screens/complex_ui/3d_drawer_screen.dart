import 'package:demo_pizza/controller/animated_drawer_right_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'animated_drawer.dart';

class DDrawerScreen extends StatelessWidget {
  const DDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimatedControllerDrawer>(
        init: AnimatedControllerDrawer(),
        builder: (animatedControllerDrawer) {
          return Scaffold(
            body: AnimatedBuilder(
              builder: (context, _) {
                // double slide = (MediaQuery.of(context).size.width * 0.5) * (animatedControllerDrawer.animationController?.value ?? 1.0);
                double scale = 1 - (animatedControllerDrawer.animationController!.value * 0.3);
                return Stack(
                  children: [
                    ///BackGround
                    Transform.translate(
                      offset: Offset(
                          (MediaQuery.of(context).size.width * 0.7)* (animatedControllerDrawer.animationController!.value - 1) ,0
                      ),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(math.pi / 2 *(1 - animatedControllerDrawer.animationController!.value)),
                          // ..scale(scale),
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: Get.height,
                          width: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Aadesh Mishra",
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 26),
                                        ),
                                        const Text(
                                          "Flutter Developer",
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                        Divider(
                                          color: Colors.white.withOpacity(0.5),
                                          thickness: 0.5,
                                        ),
                                        DrawerButtons(
                                            onTap: () {
                                              print("help");
                                              animatedControllerDrawer.buttonToggle();
                                            },
                                            title: "About Us",
                                            icons: Icons.info_outlined),
                                        DrawerButtons(
                                            onTap: () {},
                                            title: "Work Experience",
                                            icons: Icons.work_history_outlined),
                                        DrawerButtons(
                                            onTap: () {},
                                            title: "Projects ",
                                            icons: Icons.phone_android_rounded),
                                        DrawerButtons(
                                            onTap: () {},
                                            title: "Educations ",
                                            icons: Icons.book_outlined),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ///ForeGround
                    Transform.translate(
                      offset: Offset(
                          (MediaQuery.of(context).size.width * 0.7)* (animatedControllerDrawer.animationController?.value ?? 1.0) ,0
                      ),
                      child: Transform(
                        transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                          ..rotateY(-math.pi * animatedControllerDrawer.animationController!.value/2)
                          ..scale(scale),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).padding.top,
                              ),
                              GestureDetector(
                                  onHorizontalDragStart: (details){},
                                  onTap: (){
                                    animatedControllerDrawer.buttonToggle();
                                  },
                                  child: const Icon(Icons.map))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              animation: animatedControllerDrawer.animationController!,
            ),
          );
        });
  }
}