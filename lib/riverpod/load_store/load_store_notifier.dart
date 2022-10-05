import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/api/controllers/pokemon_controller.dart';
import 'package:pokemon_collector/api/models/pokemon_list_model.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';

class LoadStoreNotifier extends StateNotifier<List<PokemonModel>> {
  LoadStoreNotifier() : super([]);

  int _page = 1;

  int get page => _page;

  set page(int value) {
    if (_page != value) {
      _page = value;
    }
  }

  bool _isEnabled = true;
  String? _nextPageUrl;
  String? _previousPageUrl;

  Future<void> loadDataPokemonList({String? url}) async {
    if (_isEnabled) {
      _isEnabled = false;
      List<PokemonModel> pokemonModelList = [];
      PokemonListModel pokemons = await PokemonController().loadStoreGet(url: url);
      if (pokemons.results != null) {
        for (int i = 0; i < pokemons.results!.length; i++) {
          PokemonModel pokemon = await PokemonController().loadStorePokemonGet(url: pokemons.results![i].url);
          pokemonModelList.add(pokemon);
        }
      }
      _nextPageUrl = pokemons.next;
      _previousPageUrl = pokemons.previous;
      state = pokemonModelList;
      await Future.delayed(const Duration(milliseconds: 100));
      _isEnabled = true;
    }
  }

  Future<void> loadDataPokemon({String? url}) async {
    if (_isEnabled) {
      _isEnabled = false;
      List<PokemonModel> pokemonModelList = [];
      PokemonModel pokemon = await PokemonController().loadStorePokemonGet(url: '${baseUrl}pokemon/$url');
      pokemonModelList.add(pokemon);
      state = pokemonModelList;
      await Future.delayed(const Duration(milliseconds: 100));
      _isEnabled = true;
    }
  }

  Future<void> nextPage() async {
    if (_nextPageUrl != null) {
      state = [];
      _page++;
      await loadDataPokemonList(url: _nextPageUrl);
    }
  }

  Future<void> previousPage() async {
    if (_previousPageUrl != null) {
      state = [];
      _page--;
      await loadDataPokemonList(url: _previousPageUrl);
    }
  }
}
