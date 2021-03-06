import 'dart:math';

import 'package:Hamburger/classes/recipe.dart';
import 'package:Hamburger/icons/icons.dart';
import 'package:Hamburger/screens/recipe.dart';
import 'package:Hamburger/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle common = TextStyle(color: Colors.black);

  List<String> selectedDietTypes = [];
  List<String> selectedRecipes = [];

  List<String> dietTypes = [
    "Vegetarian",
    "Ketogenic",
    "Paleo",
    "Pescatarian",
    "Atkins",
    "Vegan"
  ];

  List<Recipe> recipes = _buildRecipes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: Colors.white,
            centerTitle: true,
            // actions: [
            //   IconButton(
            //     color: textBlack,
            //     icon: Icon(Icons.favorite),
            //     onPressed: () => print("Favourite"),
            //   )
            // ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CustomIcons.hamburger,
                    color: textBlack,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Hamburger",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 50.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dietTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        backgroundColor: Colors.white,
                        label: Text(
                          dietTypes[index],
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  selectedDietTypes.contains(dietTypes[index])
                                      ? Colors.white
                                      : textBlack),
                        ),
                        selectedColor: blue,
                        selected: selectedDietTypes.contains(dietTypes[index]),
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              selectedDietTypes.add(dietTypes[index]);
                            } else {
                              selectedDietTypes.removeWhere((String name) {
                                return name == dietTypes[index];
                              });
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recipes',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    child: Container(
                      color: white,
                      height: 300.0,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(
                                        children: [
                                          Text(
                                            recipes[index].title,
                                            style: TextStyle(
                                                fontSize: 20, color: textBlack),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: _buildStarRating(
                                                recipes[index].rating),
                                          )
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            selectedRecipes.contains(
                                                    recipes[index].title)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: textBlack,
                                            size: 32,
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                      ),
                                    ),
                                    SizedBox(width: 8)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Hero(
                                  tag: index,
                                  child: Image.network(
                                    recipes[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                onLongPress: () {
                                  setState(() {
                                    String text = "";

                                    if (selectedRecipes
                                        .contains(recipes[index].title)) {
                                      selectedRecipes.removeWhere(
                                          (String name) =>
                                              name == recipes[index].title);

                                      text = "Removed from favourites";
                                    } else {
                                      selectedRecipes.add(recipes[index].title);
                                      text = "Added to favourites";
                                    }

                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(text),
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  });
                                },
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeRoute(recipes[index], index),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: recipes.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeRoute(recipes[randIndex()], 1),
          ),
        ),
        backgroundColor: Colors.white,
        label: Text(
          'Random',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        icon: Icon(
          Icons.shuffle,
          color: textBlack,
        ),
      ),
    );
  }

  List<Widget> _buildStarRating(int rating) {
    List<Widget> stars = [];
    for (var i = 0; i < 5; i++) {
      stars.add(rating > i
          ? IconShadowWidget(Icon(Icons.star, color: gold, size: 24),
              shadowColor: Colors.black12)
          : Icon(Icons.star_border));
    }

    return stars;
  }

  int randIndex() {
    return new Random().nextInt(recipes.length);
  }

  static List<Recipe> _buildRecipes() {
    List<Ingredient> ingredients = [
      Ingredient("Eggs", 2, ""),
      Ingredient("Milk", 2, "litres"),
      Ingredient("Flour", 1, "cup"),
      Ingredient("Water", 750, "ml")
    ];

    return [
      Recipe(
          "Keto pizza",
          4,
          "https://i.dietdoctor.com/wp-content/uploads/2016/01/keto_pizza_v.jpg?auto=compress%2Cformat&w=600&h=338&fit=crop",
          ingredients),
      Recipe(
          "Classic bacon and eggs",
          5,
          "https://i.dietdoctor.com/wp-content/uploads/2015/12/DD-14.jpg?auto=compress%2Cformat&w=600&h=338&fit=crop",
          ingredients),
      Recipe(
          "Keto naan bread",
          4,
          "https://i.dietdoctor.com/wp-content/uploads/2016/03/DD-70.jpg?auto=compress%2Cformat&w=600&h=338&fit=crop",
          ingredients),
      Recipe(
          "Low-carb garlic chicken",
          5,
          "https://i.dietdoctor.com/wp-content/uploads/2015/12/Ajopollo11.jpg?auto=compress%2Cformat&w=1600&h=1067&fit=crop 1600w",
          ingredients),
    ];
  }
}
