import 'package:flutter/material.dart';
import 'package:pokemon_collector/globals/globals.dart';

PreferredSizeWidget appBarCustom({String title = '', required BuildContext context, Function()? function}) {

  return AppBar(
    backgroundColor: appBarColor,
    title: Text(title, style: const TextStyle(color: Colors.white)),
    leading: MaterialButton(
      onPressed: () {
        if (function != null) {
          function();
        }
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back, color: Colors.white),
    ),
  );
}
