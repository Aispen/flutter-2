import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_02/FoodDetails.dart';
import 'package:flutter_02/FoodModel.dart';
import 'comments.dart';
import 'dart:convert';
import 'dart:async';

class Drink extends StatefulWidget {
  @override
  _DrinkState createState() => _DrinkState();
}

class _DrinkState extends State<Drink> {
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/Drinks.json");
  }

  _commentButtonPress(context) {
    setState(() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => FoodComments(3)));
    });
  }

  Future<List<Food>> _getFoods() async {
    String jsonString = await _loadFromAsset();
    var jsonResponse = jsonDecode(jsonString);
    List<Food> foods = [];
    for (var u in jsonResponse) {
      Food food = Food(
          u["id"], u["title"], u["description"], u["ingredients"], u["howto"]);
      foods.add(food);
    }
    print(foods.length);
    return foods;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: Center(
            child: FutureBuilder(
              builder: (context, snapshot) {
                //var foodData = snapshot.data;
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetail(snapshot.data[index])));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0,
                                bottom: 25.0,
                                left: 16.0,
                                right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index].title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                Text(
                                  snapshot.data[index].description,
                                  style: TextStyle(color: Colors.grey.shade700),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              },
              future: _getFoods(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.comment),
            onPressed: () {
              _commentButtonPress(context);
            }));
  }
}
