import 'package:dartz/dartz.dart';
import '../error/failure.dart';

//Предотвращение реализация разных имён; реализация явного абстрактного класса, который невозможно вывести

abstract class UseCase<Type, Params> { // Type - без ошибок; Params - вызовет незначительные изменения в usecases
  Future<Either<Failure, Type>> call(Params params);
}
