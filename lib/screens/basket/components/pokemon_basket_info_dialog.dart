import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/riverpod/load_basket/load_basket_provider.dart';

class PokemonBasketInfoDialog extends ConsumerWidget {
  final PokemonModel pokemon;
  final int index;
  final TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(14));

  PokemonBasketInfoDialog({Key? key, required this.pokemon, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(16)),
        height: getProportionateScreenWidth(300),
        color: mainColorLight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Имя:', style: _textStyle),
                    Text('Рост:', style: _textStyle),
                    Text('Вес:', style: _textStyle),
                    SizedBox(height: getProportionateScreenWidth(8)),
                    Text('Способности:', style: _textStyle),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${pokemon.name}', style: _textStyle),
                      Text('${pokemon.height}', style: _textStyle),
                      Text('${pokemon.weight}', style: _textStyle),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(22),
                          left: getProportionateScreenWidth(55),
                        ),
                        child: SizedBox(
                          height: getProportionateScreenWidth(100),
                          child: ListView.builder(
                            itemBuilder: (context, int index) {
                              if (index + 1 != pokemon.abilities?.length) {
                                return Text('- ${pokemon.abilities?[index].ability?.name};', style: _textStyle);
                              } else {
                                return Text('- ${pokemon.abilities?[index].ability?.name}.', style: _textStyle);
                              }
                            },
                            itemCount: pokemon.abilities?.length,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                color: mainColorLighten,
                onPressed: () async {
                  ref.read(loadBasketProvider.notifier).removeItem(index: index);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(16)),
                  child: Text(
                    'Удалить из корзины',
                    style: TextStyle(fontSize: getProportionateScreenWidth(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
