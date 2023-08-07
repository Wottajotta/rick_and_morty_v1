import 'package:equatable/equatable.dart';

// Реализация первой сущности - PersonEntity:

class PersonEntity extends Equatable {
  //Создание переменных для получение ответа от api и расширение от библиотеки Equatable, для переопределения переменных, без использования шаблонов
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime created;

  const PersonEntity(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.created});

  @override // Реализация props для переопределения переменных
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        created
      ];
}

class LocationEntity {
  // создание класса для массива данных с api
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});
}
