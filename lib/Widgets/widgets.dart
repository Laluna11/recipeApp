import 'package:flutter/material.dart';

import '../add_recipe.dart';
import '../main.dart';

Widget appBarView() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Recipes',
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.white,
          ),
        ),
        Image.asset(
          'assets/images/chef.png',
          height: 60,
          color: Colors.black,
        ),
      ],
    ),
  );
}

Widget showDrawer(BuildContext context) {
  return ListView(
    children: <Widget>[
      const UserAccountsDrawerHeader(
        accountName: Text("Lina"),
        accountEmail: Text("smth@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            "LA",
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        otherAccountsPictures: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "LA",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      ListTile(
        title: const Text("Recipes"),
        trailing: const Icon(Icons.restaurant_menu),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
      ),
      ListTile(
        title: const Text("Add New Recipe"),
        trailing: const Icon(Icons.add),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddRecipe(),
            ),
          );
        },
      ),
      const Divider(thickness: 1, color: Colors.black,),
      ListTile(
        title: const Text("Close"),
        trailing: const Icon(Icons.close),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
