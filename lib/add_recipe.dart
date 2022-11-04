import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/Recipe.dart';
import 'Provider/recipes_provider.dart';
import 'Widgets/widgets.dart';
import 'main.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late Recipe rec;

  @override
  Widget build(BuildContext context) {
    // RecipeProvider recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: showDrawer(context),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appBarView(),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Recipe name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Recipe name',
                    prefixIcon: Icon(Icons.fastfood_rounded),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Recipe description';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Recipe description',
                    prefixIcon: Icon(Icons.menu_book_outlined),
                  ),
                  maxLines: 2,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Recipe price';
                    }
                    return null;
                  },
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Recipe price',
                    prefixIcon: Icon(Icons.price_change),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text("Back"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          rec = Recipe(
                            name: nameController.text,
                            desc: descriptionController.text,
                            price: double.parse(priceController.text),
                          );
                          context.read<RecipeProvider>().addRecipe(rec);
                          context.read<RecipeProvider>().viewRecipes();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: const Text("ADD"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
