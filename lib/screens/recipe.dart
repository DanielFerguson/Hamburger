import 'package:Hamburger/classes/recipe.dart';
import 'package:Hamburger/icons/icons.dart';
import 'package:Hamburger/screens/step.dart';
import 'package:Hamburger/utils/styles.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 8,
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
              title: Text(
                widget.recipe.title,
                textAlign: TextAlign.center,
              ),
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
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                    child: Row(
                      children: [
                        Icon(
                          CustomIcons.stopwatch,
                          color: white,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "1.2 Hours",
                          style: regularWhite,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Icon(
                          CustomIcons.people,
                          color: white,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Will Feed 6 People",
                          style: regularWhite,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Text(
                'Ingredients',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Material(
                    color: white,
                    child: Container(
                      child: InkWell(
                        splashColor: splashBlack,
                        onTap: () => setState(() {
                          if (_selectedIngredients.contains(
                              widget.recipe.ingredients[index].name)) {
                            _selectedIngredients.removeWhere((String name) =>
                                name == widget.recipe.ingredients[index].name);
                          } else {
                            _selectedIngredients
                                .add(widget.recipe.ingredients[index].name);
                          }
                        }),
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(unselectedWidgetColor: textBlack),
                              child: Checkbox(
                                key: Key(widget.recipe.ingredients[index].name),
                                value: _selectedIngredients.contains(
                                    widget.recipe.ingredients[index].name),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    value
                                        ? _selectedIngredients.add(widget
                                            .recipe.ingredients[index].name)
                                        : _selectedIngredients.removeWhere(
                                            (String name) =>
                                                name ==
                                                widget.recipe.ingredients[index]
                                                    .name);
                                  });
                                },
                              ),
                            ),
                            Text(
                              widget.recipe.ingredients[index].name,
                              style: TextStyle(color: textBlack),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: widget.recipe.ingredients.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          if (_selectedIngredients.length == widget.recipe.ingredients.length)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StepRoute(widget.recipe, widget.tag),
                ),
              )
            }
          else
            {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Have you got all of the ingredients yet?"),
                  duration: Duration(seconds: 3),
                ),
              )
            }
        },
        backgroundColor: Colors.white,
        label: Text(
          'Let\'s Cook',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
