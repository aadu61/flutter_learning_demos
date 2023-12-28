import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

import '../controller/3d_modle_rendring_controller.dart';

class ModleRender extends StatelessWidget {
  const ModleRender({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ModleRendringController>(
      init: ModleRendringController(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: const Text("3d Model Rendring "),
            actions: [
              IconButton(
                  onPressed: () =>
                      logic.controller.value?.animationName = 'Start_Liftoff',
                  icon: const Icon(Icons.change_circle)),
              IconButton(
                  onPressed: () =>
                      logic.controller.value?.play(repetitions: 3),
                  icon: const Icon(Icons.change_circle_outlined)),
            ],
          ),
          body: O3D.asset(
            src: 'assets/3d/buster_drone.glb',
            debugLogging: true,
            ar: true,
            controller: logic.controller.value,
          ),
        );
      },
    );
  }
}
