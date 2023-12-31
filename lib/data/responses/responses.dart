import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);

// from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.email, this.phone, this.link);

// from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

// from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgetPasswordResponse(this.support);
  //from json
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServicesResponse(this.id, this.title, this.image);
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;
  BannersResponse(this.id, this.title, this.image, this.link);
  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoresResponse(this.id, this.title, this.image);
  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServicesResponse>? services;
  @JsonKey(name: 'stores')
  List<StoresResponse>? stores;
  @JsonKey(name: 'banners')
  List<BannersResponse>? banners;

  HomeDataResponse(this.services, this.stores, this.banners);

// // toJson
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

//fromJson
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

// toJson
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

//fromJson
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}

@JsonSerializable()
class StoreDetailsReponse extends BaseResponse {
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;
  StoreDetailsReponse(
      this.image, this.id, this.title, this.details, this.services, this.about);
  // toJson
  Map<String, dynamic> toJson() => _$StoreDetailsReponseToJson(this);

//fromJson
  factory StoreDetailsReponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsReponseFromJson(json);
}
