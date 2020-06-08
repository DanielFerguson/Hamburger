import 'package:meta/meta.dart';

class Recipe {
  String title;
  int rating;
  String imageUrl;
  List<Ingredient> ingredients;
  List<Step> steps;

  // TODO Get list of ingredients from all of the steps
  List<Ingredient> _reduceIngredients() {
    return [];
  }

  Recipe(
      String title, int rating, String imageUrl, List<Ingredient> ingredients) {
    this.title = title;
    this.rating = rating;
    this.imageUrl = imageUrl;
    this.ingredients = ingredients;
  }
}

class Ingredient {
  String name;
  int amount;
  String measurement;

  Ingredient(String name, int amount, String measurement) {
    this.name = name;
    this.amount = amount;
    this.measurement = measurement;
  }
}

class Step {
  List<Ingredient> ingredientsRequired;
  int order;
  String instructions;
  String imgLink;
}
