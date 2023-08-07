import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({super.key, required this.personResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // При нажатии на карточку персонажа - переносит в окно с детальной информацией
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      },
      child: Card(
        // Возвращает карточки персонажей
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(
                // Возвращает картинку, при поиске персонажа
                imageUrl: personResult.image,
                height: 800,
                wigth: 80,
              ),
            ),
            Padding(
              //Возвращает имя, при поиске персонажа
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
            Padding(
              //Возвращает локацию, при поиске персонажа
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
