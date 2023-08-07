// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import '../../../../core/error/failure.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

// Получение списка персонажей через Cubit

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) {
      return; // Проверка состояние персонажей (если загружаются)
    }

    final currenState = state;

    var oldPerson = <PersonEntity>[];
    if (currenState is PersonLoaded) {
      // Проверка состояние персонажей (если загрузились)
      oldPerson = currenState.personsList;
    }

    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson //Ошибка или получение списка персонажей
        .fold(
            (error) => emit(
                  PersonError(
                    message: _mapFailureToMessage(error),
                  ),
                ), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      print("List lenght: ${persons.length.toString()}");
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    //Метод для вывода ошибок
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
