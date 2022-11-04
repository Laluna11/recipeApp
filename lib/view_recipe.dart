import 'package:flutter/material.dart';
import 'package:food_menu/Models/Recipe.dart';
import 'package:provider/provider.dart';

import 'Provider/recipes_provider.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool on = false;

  List<BoxShadow> b = [
    const BoxShadow(
      blurRadius: 20,
      color: Colors.grey,
      spreadRadius: 10,
    ),
  ];

  List<BoxShadow> b0 = [
    const BoxShadow(
      blurRadius: 20,
      color: Colors.red,
      spreadRadius: 10,
    ),
  ];

  switching() {
    Future.delayed(const Duration(seconds: 1), () {
      print('ON - OF');
      setState(() {
        on = !on;
      });
      switching();
    });
  }

  @override
  void initState() {
    switching();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.watch<RecipeProvider>().data[recipe].name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: on ? b0 : b,
              ),
              child: SizedBox(
                height: 400,
                child: GestureDetector(
                  onTap: () {
                    print('DOUBLE TAPPED');
                  },
                  child: const CircleAvatar(
                    radius: 150.0,
                    backgroundImage: NetworkImage(
                        'https://assets.vogue.in/photos/5ed8e32c64872e9ac717c767/master/pass/pizza%20recipe%20pizza%20to%20make%20at%20home%20quick%20and%20easy%20recipes.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            const Text(
              "Details: ",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
