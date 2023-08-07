// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final scrollController = ScrollController();
  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Bet',
    'Jerry',
  ];
  void setupScrollController(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            BlocProvider.of<PersonSearchBloc>(context);
          }
        }
      },
    );
  }

  //Возвращает компонент справа (в данном случае - удаление поиска)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  //Вызывается, когда мы нажимаем на кнопку (showResults) результат поиска
  @override
  Widget buildResults(BuildContext context) {
    setupScrollController(context);
    int page = 1;
    print('Inside custom search delegate and search query is $query');

    //Показывает результаты поиска, с помощью BlocProvider
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query, page));
    // Обработка состояний
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        List<PersonEntity> personsSearch = [];
        bool isSearchLoading = false;
        if (state is PersonSearchLoading && state.isFirstSearchFetch) {
          return _loadingindicator();
        } else if (state is PersonSearchLoading) {
          personsSearch = state.oldPersonsSearchList;
          isSearchLoading = true;
        } else if (state is PersonSearchLoaded) {
          personsSearch = state.personsSearchList;
          page++;
          if (personsSearch.isEmpty) {
            return _showErrorText('No Characters with that name found');
          }

          return ListView.builder(
            itemCount: personsSearch.isNotEmpty ? personsSearch.length + 1 : 0,
            itemBuilder: (context, index) {
              //PersonEntity result = personsSearch[index];
              if (index < personsSearch.length) {
                page++;
                return SearchResult(personResult: personsSearch[index]);
                
              }
              return null;
            },
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
        return _loadingindicator();
      },
    );
  }

  //Метод вывода ошибки, при поиске несуществующего персонажа
  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Обрабатывает то, что вводит пользователь
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        );
      },
      itemCount: _suggestions.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  //Метод отображения индикатора загрузки
  Widget _loadingindicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
