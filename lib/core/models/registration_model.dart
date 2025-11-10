import 'package:flutter/foundation.dart';

@immutable
class RegistrationModel {
  final String name;
  final String whatsapp;
  final String cep;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;

  const RegistrationModel({
    this.name = '',
    this.whatsapp = '',
    this.cep = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.cidade = '',
  });

  bool get isEmpty =>
      name.isEmpty ||
      whatsapp.isEmpty ||
      cep.isEmpty ||
      rua.isEmpty ||
      numero.isEmpty ||
      bairro.isEmpty ||
      cidade.isEmpty;

  RegistrationModel copyWith({
    String? name,
    String? whatsapp,
    String? cep,
    String? rua,
    String? numero,
    String? bairro,
    String? cidade,
  }) {
    return RegistrationModel(
      name: name ?? this.name,
      whatsapp: whatsapp ?? this.whatsapp,
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrationModel &&
        other.name == name &&
        other.whatsapp == whatsapp &&
        other.cep == cep &&
        other.rua == rua &&
        other.numero == numero &&
        other.bairro == bairro &&
        other.cidade == cidade;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      whatsapp,
      cep,
      rua,
      numero,
      bairro,
      cidade,
    );
  }
}