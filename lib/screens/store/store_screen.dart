import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/globals/widgets/app_bar_custom.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_provider.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_notifier.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_provider.dart';
import 'package:pokemon_collector/screens/store/components/page_button_widget.dart';
import 'package:pokemon_collector/screens/store/components/product_button_widget.dart';

class StoreScreen extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  StoreScreen({Key? key}) : super(key: key);

  List<Widget> pokemonListCreate({required List<PokemonModel> pokemonList}) {
    List<Widget> list = [];
    for (PokemonModel pokemon in pokemonList) {
      if (pokemon != pokemonList.last) {
        list.add(
          Padding(
            padding: EdgeInsets.only(bottom: getProportionateScreenWidth(8)),
            child: ProductButtonWidget(pokemon: pokemon),
          ),
        );
      } else {
        list.add(
          ProductButtonWidget(pokemon: pokemon),
        );
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoadStoreNotifier loadStoreRead = ref.read(loadStoreProvider.notifier);
    return Material(
      child: InkWell(
        onTap: () {
          _searchFocus.unfocus();
        },
        child: Scaffold(
          appBar: appBarCustom(
            title: 'Магазин покемонов',
            context: context,
            function: () {
              loadStoreRead.page = 1;
            },
          ),
          backgroundColor: mainColor,
          body: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(16)),
            child: (!ref.watch(isLoadingProvider.select((value) => value)))
                ? SingleChildScrollView(
                  child: Column(
                      children: [
                        Stack(
                          children: [
                            TextField(
                              controller: _searchController,
                              focusNode: _searchFocus,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 0), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColorLighten, width: 2),
                                ),
                                hintStyle: const TextStyle(color: Colors.white54),
                                hintText: 'Имя покемона...',
                              ),
                              onEditingComplete: () async {
                                _searchFocus.unfocus();
                                ref.read(isLoadingProvider.notifier).setState(true);
                                if (_searchController.text != '') {
                                  await loadStoreRead.loadDataPokemon(url: _searchController.text);
                                } else {
                                  await loadStoreRead.loadDataPokemonList();
                                }
                                ref.read(isLoadingProvider.notifier).setState(false);
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getProportionateScreenWidth(16),
                                  right: getProportionateScreenWidth(8),
                                ),
                                child: Icon(Icons.search, color: mainColorLighten),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenWidth(16)),
                        SizedBox(
                          width: double.infinity,
                          height:
                              getProportionateScreenWidth(52 * double.parse(loadStoreRead.state.length.toString()) + 8),
                          child: Column(
                            children: pokemonListCreate(pokemonList: loadStoreRead.state),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(8)),
                        Row(
                          children: [
                            const PageButtonWidget(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(4)),
                              child: Text('${loadStoreRead.page}',
                                  style: TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(16))),
                            ),
                            const PageButtonWidget(isRight: true),
                          ],
                        ),
                      ],
                    ),
                )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
