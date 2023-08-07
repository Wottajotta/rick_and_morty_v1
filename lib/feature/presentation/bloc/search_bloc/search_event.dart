import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();
  
  @override
  List<Object?> get props => [];
}

class SearchPersons extends PersonSearchEvent {
  final String personQuery;
  final int page;

  const SearchPersons(this.personQuery, this.page);

}