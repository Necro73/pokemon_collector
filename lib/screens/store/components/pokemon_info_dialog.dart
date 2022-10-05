import 'package:flutter/material.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';

class PokemonInfoDialog extends StatelessWidget {
  final PokemonModel pokemon;
  final TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(14));

  PokemonInfoDialog({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  if (prefs.getStringList('basket') == null) {
                    await prefs.setStringList('basket', <String>[]);
                  }
                  await prefs.setStringList('basket', prefs.getStringList('basket')! + [pokemon.locationAreaEncounters!.substring(0, 35)]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(16)),
                  child: Text(
                    'Добавить в корзину',
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