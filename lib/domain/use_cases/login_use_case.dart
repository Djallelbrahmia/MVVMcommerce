import 'package:dartz/dartz.dart';
import 'package:ecommvvm/app/functions.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/domain/repository/repository.dart';
import 'package:ecommvvm/domain/use_cases/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.Login(Loginrequest(
        input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
