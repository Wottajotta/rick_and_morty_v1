import 'package:equatable/equatable.dart';
// Обработка ошибок
abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}