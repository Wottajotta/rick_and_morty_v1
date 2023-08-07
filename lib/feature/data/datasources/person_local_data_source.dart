

import 'dart:convert';
import 'package:rick_and_morty_app/core/error/exception.dart';
import '../models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  // Вызывают кэш [List<PersonModel>], который был вазван последний раз
  // пользователь был подключен к интернету
  //
  // Ловит [CacheException], если отсутствует кэш

  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

// Реализация класса
// ignore: constant_identifier_names
const CACHED_PERSONS_LIST = "CACHED_PERSONS_LIST";

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});
 // Получение данных о последних пользователях из кэша, с помощью shared_preferens;
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }
 // Получение кэша о пользователях, с помощью shared_preferens;
  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    // ignore: avoid_print
    print("Persons to write Cache: ${jsonPersonsList.length}");
    // ignore: void_checks
    return Future.value(jsonPersonsList);
  }
}
