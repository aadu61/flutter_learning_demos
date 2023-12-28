import 'package:demo_pizza/controller/animated_drawer_right_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedDrawerRightSide extends StatelessWidget {
  const AnimatedDrawerRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimatedControllerDrawer>(
        init: AnimatedControllerDrawer(),
        builder: (animatedControllerDrawer) {
      return Scaffold(
        body: AnimatedBuilder(
          builder: (context, _) {
            double slide = (MediaQuery.of(context).size.width * 0.5) * (animatedControllerDrawer.animationController?.value ?? 1.0);
            double scale =
                1 - (animatedControllerDrawer.animationController!.value * 0.3);
            return Stack(
              children: [
                ///BackGround
                Container(
                  height: Get.height,
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
                                onTap: () {},
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
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),

                ///ForeGround
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        GestureDetector(
                            onTap: (){
                              animatedControllerDrawer.buttonToggle();
                            },
                            child: const Icon(Icons.map))
                      ],
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

class DrawerButtons extends StatelessWidget {
  String title;
  IconData icons;
  Null Function() onTap;

  DrawerButtons({
    super.key,
    required this.onTap,
    required this.title,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icons,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
