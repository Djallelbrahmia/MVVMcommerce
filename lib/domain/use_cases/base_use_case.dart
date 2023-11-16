import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
