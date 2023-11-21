import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/domain/repository/repository.dart';
import 'package:ecommvvm/domain/use_cases/base_use_case.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _repository.getStoresDetails();
  }
}
