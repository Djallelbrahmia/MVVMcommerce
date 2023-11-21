import 'package:dartz/dartz.dart';
import 'package:ecommvvm/data/dada.data_source/local_data_source.dart';
import 'package:ecommvvm/data/dada.data_source/remote_data_source.dart';
import 'package:ecommvvm/data/mapper/mapper.dart';
import 'package:ecommvvm/data/network.dart/error_handler.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';
import 'package:ecommvvm/data/network.dart/network_info.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/domain/repository/repository.dart';

class RepositoryImplementer implements Repository {
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;

  NetworkInfo _networkInfo;
  RepositoryImplementer(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, Authentication>> Login(
      Loginrequest loginrequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginrequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          //return Biz logic error

          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponsMessage.UNKNOWN));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.forgetPassword(forgetPasswordRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          //return Biz logic error
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponsMessage.UNKNOWN));
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          //return Biz logic error

          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponsMessage.UNKNOWN));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      final response = await _localDataSource.getHome();

      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveHomeToCache(response);

            return Right(response.toDomain());
          } else {
            //return Biz logic error

            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponsMessage.UNKNOWN));
          }
        } catch (error) {
          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoresDetails() async {
    try {
      final response = await _localDataSource.getStoreDetails();

      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoresDetails();

          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveStoresDetailsToCache(response);

            return Right(response.toDomain());
          } else {
            //return Biz logic error

            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponsMessage.UNKNOWN));
          }
        } catch (error) {
          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
