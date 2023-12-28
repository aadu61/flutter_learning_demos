import 'package:demo_pizza/model/pizza_model.dart';
import 'package:demo_pizza/model/pizza_topping.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PizzaController extends GetxController with GetSingleTickerProviderStateMixin{

  RxList<Pizza> myPizzas = RxList<Pizza>([
    Pizza(
        pizzaTitle: "Greek",
        pizzaDesc: "feta cheese, black olives, red onion",
        pizzaImage: 'assets/pizzas/pizza1.png',
        pizzaPriceS: 8,
        pizzaPriceM: 11,
        pizzaPriceL: 13),
    Pizza(
        pizzaTitle: "Neapolitan",
        pizzaDesc: "mozzarella, tomatoes, oregano",
        pizzaImage: 'assets/pizzas/pizza2.png',
        pizzaPriceS: 7,
        pizzaPriceM: 10,
        pizzaPriceL: 12),
    Pizza(
        pizzaTitle: "Chicago",
        pizzaDesc: "mozzarella, tomatoes, onion",
        pizzaImage: 'assets/pizzas/pizza3.png',
        pizzaPriceS: 8,
        pizzaPriceM: 11,
        pizzaPriceL: 13),
    Pizza(
        pizzaTitle: "Sausage Pizza",
        pizzaDesc: "Pizza, Sausage Pizza Margherita Hamburger Calzone, Sausage Pizza",
        pizzaImage: 'assets/pizzas/pizza4.png',
        pizzaPriceS: 8,
        pizzaPriceM: 11,
        pizzaPriceL: 13),
    Pizza(
        pizzaTitle: "California-style pizza",
        pizzaDesc: "California-style pizza Sicilian pizza Pizza Margherita Italian cuisine, pizza, food",
        pizzaImage: 'assets/pizzas/pizza5.png',
        pizzaPriceS: 8,
        pizzaPriceM: 11,
        pizzaPriceL: 13),
    Pizza(
        pizzaTitle: "Margherita Italian",
        pizzaDesc: "Pizza Margherita Italian cuisine Chicago-style pizza Pepperoni",
        pizzaImage: 'assets/pizzas/pizza6.png',
        pizzaPriceS: 8,
        pizzaPriceM: 11,
        pizzaPriceL: 13),
  ]);

  RxList<SizePizza> sizePizza = RxList([
    SizePizza(sizeTitle: "S",isSelected: true),
    SizePizza(sizeTitle: "M",isSelected: false),
    SizePizza(sizeTitle: "L",isSelected: false),
  ]);
  RxList<Ingredient> ingredients = RxList<Ingredient>([
    Ingredient('assets/toppings/onion.png',
      <Offset>[
        Offset(0.8, 0.15),
        Offset(0.6, 0.45),
        Offset(0.7, 0.2),
        Offset(0.8, 0.55),
      ],
      false,
    ),
    Ingredient('assets/toppings/olives.png',
      <Offset>[
        Offset(0.6, 0.2),
        Offset(0.5, 0.4),
        Offset(0.7, 0.25),
        Offset(0.9, 0.50),
      ],
      false,
    ),
    Ingredient('assets/toppings/cheese.png',
      <Offset>[
        Offset(0.4, 0.3),
        Offset(0.6, 0.65),
        Offset(0.7, 0.15),
        Offset(0.9, 0.55),
      ],
      false,
    ),
    Ingredient('assets/toppings/mushrooms.png',
      <Offset>[
        Offset(0.8, 0.15),
        Offset(0.6, 0.45),
        Offset(0.7, 0.2),
        Offset(0.8, 0.55),
      ],
      false,
    ),
    Ingredient('assets/toppings/tomatos.png',
      <Offset>[
        Offset(0.6, 0.2),
        Offset(0.5, 0.4),
        Offset(0.7, 0.25),
        Offset(0.9, 0.50),
      ],
      false,
    ),
    Ingredient('assets/toppings/oregano.png',
      <Offset>[
        Offset(0.8, 0.15),
        Offset(0.6, 0.45),
        Offset(0.7, 0.2),
        Offset(0.8, 0.55),
      ],
      false,
    ),

  ]);

  RxList<Ingredient> topping = RxList<Ingredient>([]);

  late AnimationController animationController;
  final List<Animation> animationList = <Animation>[];
  late Rx<BoxConstraints> pizzaConstraints = Rx<BoxConstraints>(BoxConstraints());
  late Rx<PageController> pageController1 = Rx<PageController>(PageController(initialPage: 1, viewportFraction: 1.0));
  late Rx<PageController> pageController2 = Rx<PageController>(PageController(initialPage: 1, viewportFraction: 1.1));
  late Rx<PageController> pageController3= Rx<PageController>(PageController(initialPage: 1, viewportFraction: 1.1));


  RxDouble currentPageValue = RxDouble(0.0);
  RxDouble currentPage = RxDouble(0.0);
  RxInt counter = RxInt(0);

  RxDouble pizzaSize = RxDouble(195);
  double pizzaSizeS = 195;
  double pizzaSizeM = 215;
  double pizzaSizeL = 240;

  late int total,pizzaPrice,pizzaPriceS,pizzaPriceM,pizzaPriceL;

  RxInt toppingsPrice = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    pageController1.value = PageController(initialPage: 1, viewportFraction: 1.0);
    pageController2.value = PageController(initialPage: 1, viewportFraction: 1.1);
    pageController3.value = PageController(initialPage: 1, viewportFraction: 1.1);
    // pageController4 = PageController(initialPage: 3,viewportFraction: 0.2);

    pageController1.value.addListener(() {
        currentPageValue.value = pageController1.value.page!;

        topping.clear();
        animationList.clear();
        animationController.reset();

        for(int i=0;i<ingredients.length;i++) {
          ingredients[i].tapped = false;
          counter.value=0;
          toppingsPrice.value=0;
        }
        pageController2.value.animateToPage(
          currentPageValue.value.toInt(),
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        pageController3.value.jumpToPage(
          currentPageValue.value.toInt(),
        );

        currentPageValue.refresh();
        currentPage.refresh();
    });

    // pageController4.addListener(() {
    //     currentPage.value = pageController4.page!;
    // });
    animationController = AnimationController(
        vsync: this,duration: const Duration(milliseconds: 800)
    );


  }


  ///region function
  Widget buildIngredientsWidget(){
    List<Widget> elements =[];
    if(animationList.isNotEmpty){
      for(int i=0;i<topping.length; i++){
        Ingredient ingredient = topping[i];
        final pizzaToppingWidget = Image.asset(ingredient.image, height: 35);
        for(int j=0;j<ingredient.positions.length; j++){
          final animation = animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;

          if(i==topping.length-1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -pizzaConstraints.value.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = pizzaConstraints.value.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -pizzaConstraints.value.maxHeight * (1 - animation.value);
            } else {
              fromY = pizzaConstraints.value.maxHeight * (1 - animation.value);
            }
            if (animation.value > 0) {
              elements.add(
                Transform(transform: Matrix4.identity()
                  ..translate(
                    fromX = pizzaConstraints.value.maxHeight * positionX,
                    fromY = pizzaConstraints.value.maxHeight * positionY,
                  ),
                  child: pizzaToppingWidget,
                ),
              );
            }
          } else {
            elements.add(
              Transform(transform: Matrix4.identity()
                ..translate(
                  pizzaConstraints.value.maxHeight * positionX,
                  pizzaConstraints.value.maxHeight * positionY,
                ),
                child: pizzaToppingWidget,
              ),
            );
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }

  void buildIngredientAnimation(){
    animationList.clear();
    animationList.add(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4,0.8, curve: Curves.decelerate)
    ));
    animationList.add(CurvedAnimation(
        parent: animationController, curve: const Interval(0.1,0.5, curve: Curves.decelerate)
    ));
    animationList.add(CurvedAnimation(
        parent: animationController, curve: const Interval(0.8,0.8, curve: Curves.decelerate)
    ));
    animationList.add(CurvedAnimation(
        parent: animationController, curve: const Interval(0.5,0.7, curve: Curves.decelerate)
    ));
  }
  ///endregion

  @override
  void dispose() {
    super.dispose();
    pageController1.value.dispose();
    pageController2.value.dispose();
    pageController3.value.dispose();
    // pageController4.dispose();
    animationController.dispose();
  }


}