
class Pizza {
    String? pizzaTitle;
    String? pizzaDesc;
    String? pizzaImage;
    int? pizzaPriceS;
    int? pizzaPriceM;
    int? pizzaPriceL;

   Pizza({required this.pizzaTitle,required this.pizzaDesc,required this.pizzaImage,required this.pizzaPriceS,required this.pizzaPriceM,required this.pizzaPriceL});
   
}

class SizePizza {

    String? sizeTitle;
    bool? isSelected;

    SizePizza({this.sizeTitle, this.isSelected});
}