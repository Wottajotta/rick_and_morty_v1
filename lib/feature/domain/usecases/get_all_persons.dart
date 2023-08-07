
//Реализация usecase - получение персонажей

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/person_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> { //отображение списка персонажей
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  @override
  Future<Either<Failure,List<PersonEntity>>> call(PagePersonParams params) async { //реализация метода вызова персонажей, передаёт на уровень presentation
  return await personRepository.getAllPersons(params.page);
  }
}


class PagePersonParams extends Equatable { //Помогает принимать методу call свой параметр, а не иметь своё число или строку
  final int page;

  const PagePersonParams({required this.page});
  
  @override
  List<Object?> get props => [page];
}




