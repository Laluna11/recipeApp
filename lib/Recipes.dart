import 'package:flutter/material.dart';
import 'package:food_menu/Provider/recipes_provider.dart';
import 'package:food_menu/view_recipe.dart';
import 'package:provider/provider.dart';

import 'Db/database.dart';
import 'Models/Recipe.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({Key? key}) : super(key: key);

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  future() async {
    await context.read<RecipeProvider>().viewRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: context.watch<RecipeProvider>().data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    selectedColor: Colors.redAccent.withOpacity(0.1),
                    leading: Image.network(
                        'https://assets.vogue.in/photos/5ed8e32c64872e9ac717c767/master/pass/pizza%20recipe%20pizza%20to%20make%20at%20home%20quick%20and%20easy%20recipes.jpg'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Details(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async{
                              // int? id = context.watch<RecipeProvider>().data[index].id;
                              // await Data.instance.delete(id);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                    title:
                        Text(context.watch<RecipeProvider>().data[index].name),
                    subtitle: Text(
                        "${context.watch<RecipeProvider>().data[index].desc}"
                        "${context.watch<RecipeProvider>().data[index].price} LBP"),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }
}
