import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/data/dada.data_source/remote_data_source.dart';
import 'package:ecommvvm/data/network.dart/app_api.dart';
import 'package:ecommvvm/data/network.dart/dio_factory.dart';
import 'package:ecommvvm/data/network.dart/network_info.dart';
import 'package:ecommvvm/data/repository/repository_implementer.dart';
import 'package:ecommvvm/domain/repository/repository.dart';
import 'package:ecommvvm/domain/use_cases/forget_password.dart';
import 'package:ecommvvm/domain/use_cases/home_use_case.dart';
import 'package:ecommvvm/domain/use_cases/login_use_case.dart';
import 'package:ecommvvm/domain/use_cases/register_use_case.dart';
import 'package:ecommvvm/presentation/forgot_password/forget_password_view_model.dart';
import 'package:ecommvvm/presentation/login/login_view_model.dart';
import 'package:ecommvvm/presentation/main/home/home_view_model.dart';
import 'package:ecommvvm/presentation/register/register_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));
  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModel() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}
