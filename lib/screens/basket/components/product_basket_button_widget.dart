import 'package:flutter/material.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/screens/basket/components/pokemon_basket_info_dialog.dart';

class ProductBasketButtonWidget extends StatelessWidget {
  final PokemonModel pokemon;
  final int index;

  const ProductBasketButtonWidget({Key? key, required this.pokemon, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenWidth(8)),
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: mainColorLight,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => PokemonBasketInfoDialog(
                  pokemon: pokemon,
                  index: index,
                ),
              );
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
      ),
    );
  }
}
