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
