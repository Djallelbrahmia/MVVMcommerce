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
