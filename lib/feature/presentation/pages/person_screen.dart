import 'package:flutter/material.dart';

import '../widgets/custom_search_delegat.dart';
import '../widgets/persons_list_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton( // Кнопка поиска
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: PersonsList(),
    );
  }
}
