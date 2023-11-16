import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/domain/repository/repository.dart';
import 'package:ecommvvm/domain/use_cases/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryCode,
        input.name,
        input.email,
        input.username,
        input.password,
        input.mobileNumber,
        input.profilPicture));
  }
}

class RegisterUseCaseInput {
  String countryCode;
  String name;
  String email;
  String username;
  String password;
  String mobileNumber;
  String profilPicture;
  RegisterUseCaseInput(this.countryCode, this.name, this.email, this.username,
      this.password, this.mobileNumber, this.profilPicture);
}
