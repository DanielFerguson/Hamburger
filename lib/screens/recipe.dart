import 'package:Hamburger/classes/recipe.dart';
import 'package:Hamburger/icons/icons.dart';
import 'package:flutter/material.dart';

class RecipeRoute extends StatefulWidget {
  RecipeRoute(this.recipe, this.tag, {Key key}) : super(key: key);

  final Recipe recipe;
  final int tag;

  @override
  _RecipeRouteState createState() => _RecipeRouteState();
}

class _RecipeRouteState extends State<RecipeRoute> {
  List<String> _selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 180,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              background: Hero(
                tag: widget.tag,
                child: Image.network(
                  widget.recipe.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
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
                    'Details',
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                    child: Row(
                      children: [
                        Icon(CustomIcons.stopwatch),
                        SizedBox(width: 8),
                        Text("1.2 Hours")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 6),
                    child: Row(
                      children: [
                        Icon(CustomIcons.people),
                        SizedBox(width: 8),
                        Text("Will Feed 6 People")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Ingredients',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CheckboxListTile(
                  dense: true,
                  title: Text(widget.recipe.ingredients[index].name),
                  key: Key(widget.recipe.ingredients[index].name),
                  value: _selectedIngredients
                      .contains(widget.recipe.ingredients[index].name),
                  onChanged: (bool value) {
                    setState(() {
                      print(value);
                      value
                          ? _selectedIngredients
                              .add(widget.recipe.ingredients[index].name)
                          : _selectedIngredients.removeWhere((String name) =>
                              name == widget.recipe.ingredients[index].name);
                    });
                  },
                );
              },
              childCount: widget.recipe.ingredients.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Next - to the steps!"),
        backgroundColor: Colors.white,
        child: Icon(
          Icons.chevron_right,
          size: 32,
          color: Colors.black,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}