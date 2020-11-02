import 'package:flutter/material.dart';
import 'package:flutter_02/FoodModel.dart';
import 'package:flutter_02/comments.dart';

class FoodDetail extends StatefulWidget {
  final Food food;
  FoodDetail(this.food);

  @override
  _FoodDetailState createState() => _FoodDetailState(food);
}

class _FoodDetailState extends State<FoodDetail> {
  Food food;
  _FoodDetailState(this.food);

  _commentButtonPress(context) {
    setState(() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => FoodComments(food.id)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text("Receptas"),
        )),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, bottom: 25.0, left: 16.0, right: 16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      food.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Text(
                      food.description,
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade800),
                    ),
                    Divider(),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: new Row(
                        children: <Widget>[
                          Flexible(flex: 1, child: new Text(food.ingredients)),
                          Flexible(flex: 2, child: new Text(food.howto))
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
