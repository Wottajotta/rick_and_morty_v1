// Реализация usecase - поиск персонажей

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/person_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async { //реализация метода поиска персонажей, передаёт на уровень presentation
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable { //Помогает принимать методу call свой параметр, а не иметь своё число или строку
  final String query;

  const SearchPersonParams({required this.query});
  @override
  List<Object?> get props => [query];
}
