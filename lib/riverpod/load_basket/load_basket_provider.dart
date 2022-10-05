import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/riverpod/load_basket/load_basket_notifier.dart';

final StateNotifierProvider<LoadBasketNotifier, List<PokemonModel>> loadBasketProvider =
    StateNotifierProvider<LoadBasketNotifier, List<PokemonModel>>((ref) {
  return LoadBasketNotifier();
});
