
//Определение контракта - абстрактного класса

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure,List<PersonEntity>>> getAllPersons(int page); // Получение всех персонажей, с указанием страницы api и передача в Entity, с помощью dartz
  Future<Either<Failure,List<PersonEntity>>> searchPerson(String query); // Поиск персонажей из api по имени query и передача в Entity; Обработка ошибок, с помощью dartz
}