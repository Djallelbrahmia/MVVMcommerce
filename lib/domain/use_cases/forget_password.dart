import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/domain/repository/repository.dart';
import 'package:ecommvvm/domain/use_cases/base_use_case.dart';

class ForgetPasswordUseCaseInput {
  String email;
  ForgetPasswordUseCaseInput(this.email);
}

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordUseCaseInput, ForgetPassword> {
  Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPassword>> execute(
      ForgetPasswordUseCaseInput forgetPasswordInput) async {
    return await _repository
        .forgetPassword(ForgetPasswordRequest(forgetPasswordInput.email));
  }
}
