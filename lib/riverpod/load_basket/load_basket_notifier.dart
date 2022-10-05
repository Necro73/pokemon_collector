import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/controllers/pokemon_controller.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';

class LoadBasketNotifier extends StateNotifier<List<PokemonModel>> {
  LoadBasketNotifier() : super([]);

  bool isEnabled = true;

  Future<void> loadBasket() async {
    final List<String>? basket = prefs.getStringList('basket');
    List<PokemonModel> pokemonModelList = [];
    if (basket != null) {
      for (String pokemonAddress in basket) {
        PokemonModel pokemon = await PokemonController().loadStorePokemonGet(url: pokemonAddress);
        pokemonModelList.add(pokemon);
      }
      state = pokemonModelList;
    }
  }

  Future<void> removeItem({required int index}) async {
    final List<String>? basket = prefs.getStringList('basket');
    if (basket != null) {
      basket.removeAt(index);
      await prefs.setStringList('basket', basket);
      List<PokemonModel> pokemonModelList = state;
      pokemonModelList.removeAt(index);
      state = List<PokemonModel>.of(pokemonModelList);
    }
  }
}
