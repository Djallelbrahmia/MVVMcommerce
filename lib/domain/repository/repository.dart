import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> Login(Loginrequest loginrequest);
  Future<Either<Failure, ForgetPassword>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
}
