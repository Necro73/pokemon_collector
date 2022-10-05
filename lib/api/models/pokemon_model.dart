import 'package:pokemon_collector/api/models/ability_info_model.dart';

class PokemonModel {
  int? id;
  String? name;
  int? height;
  int? weight;
  String? locationAreaEncounters;
  List<AbilityInfoModel>? abilities;

  static PokemonModel parse(dynamic data) {
    var result = PokemonModel();
    result.id = data['id'];
    result.name = data['name'];
    result.height = data['height'];
    result.weight = data['weight'];
    result.locationAreaEncounters = data['location_area_encounters'];
    var list = data['abilities'] as List;
    result.abilities = list.map((m) => AbilityInfoModel.parse(m)).toList();
    return result;
  }
}