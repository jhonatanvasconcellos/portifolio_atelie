import 'package:atelie_portifolio/core/models/registration_model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _nameKey = 'reg_name';
const String _whatsappKey = 'reg_whatsapp';
const String _cepKey = 'reg_cep';
const String _ruaKey = 'reg_rua';
const String _numeroKey = 'reg_numero';
const String _bairroKey = 'reg_bairro';
const String _cidadeKey = 'reg_cidade';

class RegistrationNotifier extends StateNotifier<RegistrationModel> {
  final SharedPreferences prefs;

  RegistrationNotifier(this.prefs) : super(const RegistrationModel()) {
    _loadRegistration();
  }

  void _loadRegistration() {
    final name = prefs.getString(_nameKey) ?? '';
    final whatsapp = prefs.getString(_whatsappKey) ?? '';
    final cep = prefs.getString(_cepKey) ?? '';
    final rua = prefs.getString(_ruaKey) ?? '';
    final numero = prefs.getString(_numeroKey) ?? '';
    final bairro = prefs.getString(_bairroKey) ?? '';
    final cidade = prefs.getString(_cidadeKey) ?? '';
    
    state = RegistrationModel(
      name: name,
      whatsapp: whatsapp,
      cep: cep,
      rua: rua,
      numero: numero,
      bairro: bairro,
      cidade: cidade,
    );
  }

  Future<void> saveRegistration(RegistrationModel data) async {
    await prefs.setString(_nameKey, data.name);
    await prefs.setString(_whatsappKey, data.whatsapp);
    await prefs.setString(_cepKey, data.cep);
    await prefs.setString(_ruaKey, data.rua);
    await prefs.setString(_numeroKey, data.numero);
    await prefs.setString(_bairroKey, data.bairro);
    await prefs.setString(_cidadeKey, data.cidade);
    
    state = data;
  }
}

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationModel>((ref) {
  throw UnimplementedError('registrationProvider deve ser injetado no main.dart');
});