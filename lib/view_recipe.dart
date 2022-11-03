import 'package:flutter/material.dart';
import 'package:food_menu/Provider/recipes_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Image.asset('assets/images/tteokboki.jpg'),

        ],
      ),
    );
  }
}
