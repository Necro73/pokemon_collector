import 'package:flutter/material.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/screens/store/components/pokemon_info_dialog.dart';

class ProductButtonWidget extends StatelessWidget {
  final PokemonModel pokemon;

  const ProductButtonWidget({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: mainColorLight,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: MaterialButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) => PokemonInfoDialog(pokemon: pokemon));
          },
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(16)),
            child: Text(
              pokemon.name ?? '-',
              style: TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(12)),
            ),
          ),
        ),
      ),
    );
  }
}
