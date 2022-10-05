import 'package:dio/dio.dart';
import 'package:pokemon_collector/api/models/pokemon_list_model.dart';
import 'package:pokemon_collector/api/models/pokemon_model.dart';
import 'package:pokemon_collector/globals/globals.dart';

class PokemonController {

  Future<PokemonListModel> loadStoreGet({String? url}) async {
    Response response;
    if (url == null) {
      response = await Dio().get('${baseUrl}pokemon/?limit=7');
    } else {
      response = await Dio().get(url);
    }
    return PokemonListModel.parse(response.data);
  }

  Future<PokemonModel> loadStorePokemonGet({String? url}) async {
    var response = await Dio().get(url ?? '-');
    return PokemonModel.parse(response.data);
  }

  //Future<PokemonModel> randomGet() async {
  //  dynamic allList = await Dio().get('https://pokeapi.co/api/v2/pokemon/');
  //  var rng = Random();
  //  int randomValue = rng.nextInt(allList.data['count']);
  //  var response = await Dio().get('https://pokeapi.co/api/v2/pokemon/$randomValue');
  //  return PokemonModel.parse(response.data);
  //}
}



// ?limit=5&offset=3