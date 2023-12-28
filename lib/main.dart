import 'package:demo_pizza/screens/3d_modle_render.dart';
import 'package:demo_pizza/screens/complex_ui/3d_drawer_screen.dart';
import 'package:demo_pizza/screens/complex_ui/3d_rotation.dart';
import 'package:demo_pizza/screens/complex_ui/animated_drawer.dart';
import 'package:demo_pizza/screens/pizza_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:  [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            title: const Text("Pizza App"),
            onTap: (){
              Get.to(()=>const PizzaScreen());
            },

          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            title: const Text("Animated Drawer Right Side"),
            onTap: (){
              Get.to(()=>const AnimatedDrawerRightSide());
            },

          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            title: const Text("3D Animated Drawer"),
            onTap: (){
              Get.to(()=>const DDrawerScreen());
            },

          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            title: const Text("3D Image Drawer"),
            onTap: (){
              Get.to(()=>const RotationImage());
            },

          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            title: const Text("3D Modle Rendering"),
            onTap: (){
              Get.to(()=>const ModleRender());
            },

          )
        ],
      ),
    );
  }
}

