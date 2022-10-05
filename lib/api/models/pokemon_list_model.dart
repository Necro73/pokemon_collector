import 'package:pokemon_collector/api/models/pokemon_address_model.dart';

class PokemonListModel {
  int? count;
  String? next;
  String? previous;
  List<PokemonAddressModel>? results;

  static PokemonListModel parse(dynamic data) {
    var result = PokemonListModel();
    result.count = data['count'];
    result.next = data['next'];
    result.previous = data['previous'];
    var list = data['results'] as List;
    result.results = list.map((m) => PokemonAddressModel.parse(m)).toList();
    return result;
  }
}