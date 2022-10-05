import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_notifier.dart';

final StateNotifierProvider<LoadStoreNotifier, List<PokemonModel>> loadStoreProvider =
    StateNotifierProvider<LoadStoreNotifier, List<PokemonModel>>((ref) {
  return LoadStoreNotifier();
});
