import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/core/platform/network_info.dart';
import 'package:rick_and_morty_app/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/person_repository.dart';
import '../datasources/person_remote_data_source.dart';
import '../models/person_model.dart';

//Реализация методов обработки ошибок

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    //Получение персонажей
    return await _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    //Поиск персонажей
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

// Обработка запроса по персонажам из кэша
  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}