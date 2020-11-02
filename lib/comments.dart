import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class FoodComments extends StatefulWidget {
  final int foodid;
  FoodComments(this.foodid);

  @override
  _FoodCommentsState createState() => _FoodCommentsState(foodid);
}

class _FoodCommentsState extends State<FoodComments> {
  final int foodid;
  _FoodCommentsState(this.foodid);
  bool initializedStorage = false;

  List<String> _comments = [];
  LocalStorage _storage = new LocalStorage('appkey');
  TextEditingController controller = new TextEditingController();

  void _addComment(String value) {
    setState(() {
      _comments.add(value);
      _saveToStorage();
    });
  }

  void _deleteComment(int index) {
    setState(() {
      _comments.removeAt(index);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    _storage.setItem(foodid.toString(), jsonEncode(_comments));
    print(jsonEncode(_comments));
  }

  Widget _buildFutureList() {
    return FutureBuilder(
        future: _storage.ready,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (initializedStorage == false) {
            String commentString = _storage.getItem(foodid.toString());
            fromJson(commentString);
            initializedStorage = true;
          }
          if (_comments.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_comments[index].toString()),
                  onDismissed: (direction) {
                    _deleteComment(index);
                  },
                  child: index < _comments.length
                      ? _buildCommentItem(_comments[index])
                      : null,
                );
              },
              itemCount: _comments.length,
            );
          } else {
            return Center(
              child: Text("Nėra komentarų"),
            );
          }
        });
  }

  Widget _buildCommentList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_comments[index].toString()),
          onDismissed: (direction) {
            setState(() {
              _comments.removeAt(index);
            });
          },
          child: index < _comments.length
              ? _buildCommentItem(_comments[index])
              : null,
        );
      },
      itemCount: _comments.length,
    );
  }

  Widget _buildCommentItem(String comment) {
    return ListTile(trailing: Icon(Icons.arrow_right), title: Text(comment));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Komentarai"),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildFutureList()),
            TextField(
              onSubmitted: (String submittedString) {
                _addComment(submittedString);
                submittedString = '';
              },
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  hintText: "Rašyti nauja komentara.."),
            )
          ],
        ));
  }

  void toJson() {
    String jsonString = jsonEncode(_comments);
    print(jsonString);
  }

  void fromJson(jsonString) {
    List<dynamic> reallyAStringList = jsonDecode(jsonString);
    if (reallyAStringList.isNotEmpty) {
      for (String string in reallyAStringList) {
        _comments.add(string);
        print(string);
      }
    }
  }
}
