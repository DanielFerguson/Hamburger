import 'dart:ui';

import 'package:Hamburger/classes/recipe.dart';
import 'package:Hamburger/icons/icons.dart';
import 'package:Hamburger/utils/styles.dart';
import 'package:flutter/material.dart';

class StepRoute extends StatefulWidget {
  StepRoute(this.recipe, this.tag, {Key key}) : super(key: key);

  final Recipe recipe;
  final int tag;

  @override
  _StepRouteState createState() => _StepRouteState();
}

class _StepRouteState extends State<StepRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 8,
            automaticallyImplyLeading: false,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Hero(
                    tag: widget.tag,
                    child: Image.network(
                      widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 1',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Ingredients Required",
                    style: header,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Material(
                    color: white,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        widget.recipe.ingredients[index].name,
                        style: TextStyle(color: textBlack),
                      ),
                    ),
                  ),
                );
              },
              childCount: widget.recipe.ingredients.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions",
                    style: header,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("""Add the batter to the center of the 
parchment paper, and then place another 
parchment paper on top. Flatten with a 
rolling pin until the batter is at least 13”x 
18.” If you prefer thinner pasta, you can 
divide the batter into two equal batches, 
placing on two baking sheets with 
parchment paper."""),
                  SizedBox(
                    height: 16,
                  ),
                  Image.network(
                      "https://i.ytimg.com/vi/w8QjQL-LWGE/maxresdefault.jpg"),
                  SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(
          context,
        ),
        backgroundColor: Colors.white,
        label: Text(
          'Next',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
