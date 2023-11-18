import 'package:ecommvvm/app/constants.dart';
import 'package:ecommvvm/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @POST("/customer/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
  @POST("/customer/forget-password")
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);
  @POST("/customer/register")
  Future<AuthenticationResponse> register(
    @Field("email") String email,
    @Field("password") String password,
    @Field("countryCode") String countryCode,
    @Field("name") String name,
    @Field("username") String username,
    @Field("mobileNumber") String mobileNumber,
    @Field("profilPicture") String profilPicture,
  );
  @GET("/home")
  Future<HomeResponse> getHome();
}
