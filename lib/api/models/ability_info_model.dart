import 'package:pokemon_collector/api/models/ability_model.dart';

class AbilityInfoModel {
  AbilityModel? ability;
  bool? isHidden;
  int? slot;


  static AbilityInfoModel parse(dynamic data) {
    var result = AbilityInfoModel();
    result.ability = AbilityModel.parse(data['ability']);
    result.isHidden = data['is_hidden'];
    result.slot = data['slot'];
    return result;
  }
}