// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:rick_and_morty_app/core/error/exception.dart';

import '../models/person_model.dart';
import 'package:http/http.dart' as http;

//Определение контракта - абстрактного класса
abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}
////////////////////////////////////////////////////////////////////////////////////
// "https://rickandmortyapi.com/api/character/?page=$page"                        //
// "https://rickandmortyapi.com/api/character/?page=2&name=rick&status=$query"    //  
////////////////////////////////////////////////////////////////////////////////////

// Реализация контракта - получение данных из удаленного источника данных

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});
  @override // Реализация get-запроса с помощью url
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override // Реализация get-запроса с помощью url
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character/?name=$query");


   //Метод вызова get запроса
  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
