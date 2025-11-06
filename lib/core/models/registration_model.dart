class RegistrationModel {
  final String name;
  final String email;
  final String whatsapp;
  final String address;

  const RegistrationModel({
    this.name = '',
    this.email = '',
    this.whatsapp = '',
    this.address = '',
  });

  bool get isEmpty => name.isEmpty || email.isEmpty || whatsapp.isEmpty || address.isEmpty;

  RegistrationModel copyWith({
    String? name,
    String? email,
    String? whatsapp,
    String? address,
  }) {
    return RegistrationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
    );
  }
}