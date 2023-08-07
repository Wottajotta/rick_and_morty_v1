import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonSearchState {
  @override
  List<Object?> get props => [];
}

class PersonSearchLoading extends PersonSearchState {
  final List<PersonEntity> oldPersonsSearchList;
  final bool isFirstSearchFetch;

  const PersonSearchLoading(this.oldPersonsSearchList,
      {this.isFirstSearchFetch = false});

  @override
  List<Object?> get props => [oldPersonsSearchList];
}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> personsSearchList;

  const PersonSearchLoaded({required this.personsSearchList});

  @override
  List<Object?> get props => [personsSearchList];
}

class PersonSearchError extends PersonSearchState {
  final String message;

  const PersonSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
