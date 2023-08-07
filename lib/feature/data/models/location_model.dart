import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity { // Преобразование из JSON и в JSON отдельных данных Location и Origin
  LocationModel({name, url}) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
