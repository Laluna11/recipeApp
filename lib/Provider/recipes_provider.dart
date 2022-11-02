import 'dart:collection';

import 'package:flutter/material.dart';

import '../Db/database.dart';
import '../Models/Recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipe = [];
  // String realTimeString = '';

  UnmodifiableListView<Recipe> get recipe => UnmodifiableListView(_recipe);

  addRecipe(Recipe recipe) async {
    // _recipe.add(recipe);
    var data;
    try {
      data = await Data.instance.create(recipe);
      _recipe.add(recipe);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // realTimeTyping(String data) {
  //   realTimeString += data[data.length - 1];
  //   notifyListeners();
  // }

  viewRecipes() async {
    try {
      var data = await Data.instance.getAllRecipes();
      // int i = 0;
      // while (data.isNotEmpty && i <= data.length) {
      //   _recipe.add(data[i]);
      //   i++;
      // }
    } catch (e) {
      print(e);
    }
  }

  deleteRecipe(index) {
    _recipe.removeAt(index);
    notifyListeners();
  }
}
