import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_menu/Provider/recipes_provider.dart';
import 'package:food_menu/view_recipe.dart';
import 'package:provider/provider.dart';

class AllRecipes extends StatelessWidget {
  const AllRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<RecipeProvider>().recipe.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              leading: Image.asset('assets/images/tteokboki.jpg'),
              trailing: const Icon(
                Icons.remove_red_eye_outlined,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Details(),
                ),
              ),
              title: Text(context.watch<RecipeProvider>().recipe[index].name),
              subtitle: Text(
                  "${context.watch<RecipeProvider>().recipe[index].desc}"
                  "${context.watch<RecipeProvider>().recipe[index].price} LBP"),
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
}
