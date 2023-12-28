import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_pizza/controller/pizza_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PizzaScreen extends StatelessWidget {
  const PizzaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return GetX<PizzaController>(
      init: PizzaController(),
      builder: (controller) {
        return Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: statusBarHeight,
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: const MaterialScrollBehavior()
                                .copyWith(overscroll: false),
                            child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                controller: controller.pageController2.value,
                                itemCount: controller.myPizzas.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          child: Text(
                                            controller.myPizzas[index]
                                                    .pizzaTitle ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 32),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            child: Text(
                                              controller.myPizzas[index]
                                                      .pizzaDesc ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ]);
                                }),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 240,
                  alignment: Alignment.center,
                  child: LayoutBuilder(builder: (context, constraints) {
                    controller.pizzaConstraints.value = constraints;
                    controller.currentPageValue.refresh();
                    return Stack(
                      children: [
                        Center(
                          child: AnimatedContainer(
                            height: controller.pizzaSize.value,
                            duration: const Duration(milliseconds: 500),
                            child: Transform.rotate(
                              angle: controller.currentPageValue.value * 4,
                              child: Image.asset('assets/pizzas/plate_5.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: AnimatedContainer(
                            height: controller.pizzaSize.value,
                            duration: const Duration(milliseconds: 500),
                            child: ScrollConfiguration(
                              behavior: const MaterialScrollBehavior()
                                  .copyWith(overscroll: false),
                              child: PageView.builder(
                                  controller: controller.pageController1.value,
                                  itemCount: controller.myPizzas.length,
                                  onPageChanged: (value){
                                    // controller.update();
                                    controller.currentPageValue.refresh();
                                  },
                                  itemBuilder: (context, index) {
                                    final parent = controller.currentPageValue.value - index;

                                    return Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Transform.rotate(
                                        angle: parent * 4,
                                        child: Image.asset(controller
                                                .myPizzas[index].pizzaImage ??
                                            ""),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: controller.animationController,
                          builder: (context, _) {
                            return controller.buildIngredientsWidget();
                          },
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// Total Values
                SizedBox(
                  height: 50,
                  child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior()
                        .copyWith(overscroll: false),
                    child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: controller.pageController3.value,
                        itemCount: controller.myPizzas.length,
                        itemBuilder: (context, index) {
                          controller.pizzaPrice =
                              controller.myPizzas[index].pizzaPriceM ?? 0;

                          controller.pizzaPriceS =
                              controller.myPizzas[index].pizzaPriceS ?? 0;
                          controller.pizzaPriceM =
                              controller.myPizzas[index].pizzaPriceM ?? 0;
                          controller.pizzaPriceL =
                              controller.myPizzas[index].pizzaPriceL ?? 0;

                          controller.total = (controller.pizzaPrice).toInt() +
                              (controller.toppingsPrice).toInt();

                          for (var element in controller.sizePizza) {
                            if (element.isSelected!) {
                              if (element.sizeTitle == "S") {
                                controller.total =
                                    controller.pizzaPriceS.toInt() +
                                        controller.toppingsPrice.toInt();
                              } else if (element.sizeTitle == "M") {
                                controller.total =
                                    controller.pizzaPriceM.toInt() +
                                        controller.toppingsPrice.toInt();
                              } else {
                                controller.total =
                                    controller.pizzaPriceL.toInt() +
                                        controller.toppingsPrice.toInt();
                              }
                            }
                          }

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "\$${controller.total}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]);
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                ///Size S M L
                Container(
                    height: 60,
                    width: 210,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.sizePizza.length,
                        itemBuilder: (context, index) {
                          var isSelected =
                              controller.sizePizza[index].isSelected;
                          var title = controller.sizePizza[index].sizeTitle;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                for (var element in controller.sizePizza) {
                                  if (element.sizeTitle == title) {
                                    element.isSelected = true;
                                    if (element.sizeTitle == "S") {
                                      controller.pizzaSize.value =
                                          controller.pizzaSizeS;
                                    } else if (element.sizeTitle == "M") {
                                      controller.pizzaSize.value =
                                          controller.pizzaSizeM;
                                    } else {
                                      controller.pizzaSize.value =
                                          controller.pizzaSizeL;
                                    }
                                  } else {
                                    element.isSelected = false;
                                  }
                                }
                                controller.pizzaSize.refresh();
                                controller.sizePizza.refresh();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: isSelected == false
                                        ? Colors.grey[300]
                                        : Colors.orange[300],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[350]!,
                                        offset: const Offset(0, 3),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    title ?? "",
                                    style: TextStyle(
                                        color: isSelected == false
                                            ? Colors.grey[500]
                                            : Colors.black,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${controller.counter}/3",
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                ///Bottom Toppings
                Flexible(
                  child: SizedBox(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(
                                      MediaQuery.of(context).size.width,
                                      220.0)),
                            ),
                          ),
                          ///Incredient
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 70,
                            child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  height: 60,
                                  viewportFraction: 0.3,
                                  autoPlay: false,
                                  reverse: true,
                                  initialPage: 3,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemCount: controller.ingredients.length,
                                itemBuilder: (context, index, realIndex) {
                                  final ingredient =
                                      controller.ingredients[index];
                                  return GestureDetector(
                                    onTap: ingredient.tapped == false
                                        ? () {
                                            if (controller.counter < 3) {
                                              controller.topping
                                                  .add(ingredient);
                                              ingredient.tapped = true;
                                              controller.toppingsPrice++;
                                              controller.counter++;
                                              controller
                                                  .buildIngredientAnimation();
                                              controller.animationController
                                                  .forward(from: 0.0);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.front_hand_outlined,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                    SizedBox(width: 15),
                                                    Expanded(
                                                      child: Text(
                                                        "Max toppings added",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              );
                                              controller.animationController
                                                  .stop();
                                            }
                                          }
                                        : null,
                                    onLongPress: () {
                                      controller.topping.remove(ingredient);
                                      ingredient.tapped = false;
                                      controller.toppingsPrice--;
                                      controller.counter--;
                                    },
                                    child: Image.asset(
                                      ingredient.image,
                                      color: ingredient.tapped == false
                                          ? null
                                          : Colors.grey[300]!.withOpacity(0.5),
                                      colorBlendMode: ingredient.tapped == false
                                          ? null
                                          : BlendMode.lighten,
                                    ),
                                  );
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12, left: 15, right: 15),
                                  elevation: 3.0,
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Add to cart",
                                ),
                                onPressed: () {
                                  // Respond to button press
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
