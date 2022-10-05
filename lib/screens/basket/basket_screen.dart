import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/globals/widgets/app_bar_custom.dart';
import 'package:pokemon_collector/riverpod/load_basket/load_basket_notifier.dart';
import 'package:pokemon_collector/riverpod/load_basket/load_basket_provider.dart';
import 'package:pokemon_collector/screens/basket/components/product_basket_button_widget.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoadBasketNotifier loadBasketRead = ref.read(loadBasketProvider.notifier);
    return Material(
      child: Scaffold(
        appBar: appBarCustom(title: 'Корзина', context: context),
        backgroundColor: mainColor,
        body: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(16)),
          child: (ref.watch(loadBasketProvider.select((value) => value.length)) > 0)
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      ProductBasketButtonWidget(pokemon: loadBasketRead.state[index], index: index),
                  itemCount: ref.watch(loadBasketProvider.select((value) => value)).length,
                )
              : const SizedBox(
                  width: double.infinity,
                  child: Text('Пусто', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                ),
        ),
      ),
    );
  }
}
