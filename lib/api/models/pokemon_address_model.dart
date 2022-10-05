class PokemonAddressModel {
  String? name;
  String? url;

  static PokemonAddressModel parse(dynamic data) {
    var result = PokemonAddressModel();
    result.name = data['name'];
    result.url = data['url'];
    return result;
  }
}