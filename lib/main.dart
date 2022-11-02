import 'package:flutter/material.dart';
import 'package:food_menu/Provider/recipes_provider.dart';
import 'package:food_menu/add_recipe.dart';
import 'package:provider/provider.dart';
import 'Recipes.dart';
import 'Widgets/widgets.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeProvider(),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),

    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: showDrawer(context),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appBarView(),
      ),
      body: const AllRecipes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddRecipe(),
            ),
          );
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
