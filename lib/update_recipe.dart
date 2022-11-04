import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/Recipe.dart';
import 'Provider/recipes_provider.dart';
import 'main.dart';

class Update extends StatefulWidget {
  const Update({
    Key? key,
    required this.name,
    required this.desc,
    required this.price,
    required this.id,
  }) : super(key: key);
  final int? id;
  final String name;
  final String desc;
  final double price;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  Recipe? recipe;

  // @override
  // void initState() {
  //   recipe = context.read<RecipeProvider>().getRecipeById(widget.id);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    Future<Recipe> future() async {
      // recipe= context.read<RecipeProvider>().updateRecipe(context.watch<RecipeProvider>().data[id]);
      return await context.read<RecipeProvider>().getRecipeById(id);
    }

    TextEditingController nameController = TextEditingController(text: widget.name);
    TextEditingController descriptionController = TextEditingController(text: widget.desc);
    TextEditingController priceController = TextEditingController(text: "${widget.price}");

    final _formkey = GlobalKey<FormState>();
    Recipe rec;

    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        // priceController.text = "${snapshot.data?.price}";
        // nameController.text = "${snapshot.data?.name}";
        // descriptionController.text = "${snapshot.data?.desc}";
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        // initialValue: 'String',
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
                                  id: id,
                                  name: nameController.text,
                                  desc: descriptionController.text,
                                  price: double.parse(priceController.text),
                                );
                                context
                                    .read<RecipeProvider>()
                                    .updateRecipe(rec);
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
