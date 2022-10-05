class AbilityModel {
  String? name;
  String? url;

  static AbilityModel parse(dynamic data) {
    var result = AbilityModel();
    result.name = data['name'];
    result.url = data['url'];
    return result;
  }
}