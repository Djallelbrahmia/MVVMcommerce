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
  Services toDomain() {
    return Services(this?.id.orEmpty() ?? "", this?.title.orEmpty() ?? "",
        this?.image.orEmpty() ?? "");
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(this?.id.orEmpty() ?? "", this?.title.orEmpty() ?? "",
        this?.image.orEmpty() ?? "");
  }
}

extension BannersResponseMapper on BannersResponse? {
  Banners toDomain() {
    return Banners(this?.id.orEmpty() ?? "", this?.title.orEmpty() ?? "",
        this?.image.orEmpty() ?? "", this?.link.orEmpty() ?? "");
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Services>()
            .toList();

    List<Stores> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                Iterable.empty())
            .cast<Stores>()
            .toList();

    List<Banners> mappedBanners =
        (this?.data?.banners?.map((bannerAd) => bannerAd.toDomain()) ??
                Iterable.empty())
            .cast<Banners>()
            .toList();

    var data = HomeData(mappedStores, mappedBanners, mappedServices);
    return HomeObject(data);
  }
}
