import 'package:ecommvvm/app/extensions.dart';
import 'package:ecommvvm/data/responses/responses.dart';
import 'package:ecommvvm/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? "", this?.link?.orEmpty() ?? "");
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.contacts?.toDomain(), this?.customer?.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(this?.support.orEmpty() ?? "");
  }
}

extension ServiceResponseMapper on ServicesResponse? {
  ServicesResponse toDomain() {
    return ServicesResponse(this?.id.orEmpty() ?? "",
        this?.title.orEmpty() ?? "", this?.image.orEmpty() ?? "");
  }
}

extension StoresResponseMapper on StoresResponse? {
  StoresResponse toDomain() {
    return StoresResponse(this?.id.orEmpty() ?? "", this?.title.orEmpty() ?? "",
        this?.image.orEmpty() ?? "");
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannersResponse toDomain() {
    return BannersResponse(
        this?.id.orEmpty() ?? "",
        this?.title.orEmpty() ?? "",
        this?.image.orEmpty() ?? "",
        this?.link.orEmpty() ?? "");
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> mappedServices = this
            ?.services
            ?.map((service) => service.toDomain())
            .cast<Services>()
            .toList() ??
        Iterable.empty().cast<Services>().toList();
    List<Banners> mappedBanners = this
            ?.banners
            ?.map((banners) => banners.toDomain())
            .cast<Banners>()
            .toList() ??
        Iterable.empty().cast<Banners>().toList();
    List<Stores> mappedStores = this
            ?.stores
            ?.map((stores) => stores.toDomain())
            .cast<Stores>()
            .toList() ??
        Iterable.empty().cast<Stores>().toList();
    var data = HomeData(mappedStores, mappedBanners, mappedServices);
    return HomeObject(data);
  }
}
