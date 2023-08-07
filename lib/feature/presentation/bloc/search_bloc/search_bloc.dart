// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';
import '../../../domain/usecases/search_person.dart';
import 'dart:async';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  //int page = 1;

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
         int page = 1;
    if (state is PersonSearchLoading) {
      return;
    }

    final currentState = state;
    var oldSearchPerson = <PersonEntity>[];

    if (currentState is PersonSearchLoaded) {
      oldSearchPerson = currentState.personsSearchList;
    }

    emit(PersonSearchLoading(oldSearchPerson, isFirstSearchFetch: page == 1));

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: event.personQuery));
    emit(
      failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) {
          page++;
          return PersonSearchLoaded(personsSearchList: person);
        },
      ),
    );
  }


String _mapFailureToMessage(Failure failure) {
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