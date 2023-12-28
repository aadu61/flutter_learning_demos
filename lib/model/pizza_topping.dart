import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ingredient {
  Ingredient(this.image,this.positions,this.tapped);
  final String image;
  final List<Offset> positions;
  bool tapped;
}

