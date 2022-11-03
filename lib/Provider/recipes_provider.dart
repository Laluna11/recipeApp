import 'dart:collection';

import 'package:flutter/material.dart';

import '../Db/database.dart';
import '../Models/Recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipe = [];
   List<Recipe> data = [];
  // String realTimeString = '';

  UnmodifiableListView<Recipe> get recipe => UnmodifiableListView(_recipe);

  addRecipe(Recipe recipe) async {
    // _recipe.add(recipe);
    var data;
    try {
      data = await Data.instance.create(recipe);
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
      data = await Data.instance.getAllRecipes();
      return data;
    } catch (e) {
      print(e);
    }
  }

  getRecipeById(index)async {
    return await Data.instance.getRecipe(index);
  }

  deleteRecipe(index) async {
    try{
      int a = await Data.instance.delete(index);
      print(a);
    }catch(e){
      print(e);
    }
    notifyListeners();
  }
}
