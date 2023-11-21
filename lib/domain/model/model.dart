class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}

class Customer {
  String id;
  String name;
  int numberOfNotification;
  Customer(this.id, this.name, this.numberOfNotification);
}

class Contacts {
  String email;
  String phone;
  String contact;
  Contacts(this.email, this.phone, this.contact);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.contacts, this.customer);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class ForgetPassword {
  String support;
  ForgetPassword(this.support);
}

class Services {
  String id;
  String title;
  String image;
  Services(this.id, this.title, this.image);
}

class Stores {
  String id;
  String title;
  String image;
  Stores(this.id, this.title, this.image);
}

class Banners {
  String id;
  String title;
  String image;
  String link;

  Banners(this.id, this.title, this.image, this.link);
}

class HomeData {
  List<Stores> stores;
  List<Banners> banners;
  List<Services> services;
  HomeData(this.stores, this.banners, this.services);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

class StoreDetails {
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;
  StoreDetails(
      this.image, this.id, this.title, this.details, this.services, this.about);
}
