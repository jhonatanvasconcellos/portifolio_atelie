import 'package:atelie_portifolio/core/models/registration_model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _nameKey = 'reg_name';
const String _emailKey = 'reg_email';
const String _whatsappKey = 'reg_whatsapp';
const String _addressKey = 'reg_address';

class RegistrationNotifier extends StateNotifier<RegistrationModel> {
  final SharedPreferences prefs;

  RegistrationNotifier(this.prefs) : super(const RegistrationModel()) {
    _loadRegistration();
  }

  void _loadRegistration() {
    final name = prefs.getString(_nameKey) ?? '';
    final email = prefs.getString(_emailKey) ?? '';
    final whatsapp = prefs.getString(_whatsappKey) ?? '';
    final address = prefs.getString(_addressKey) ?? '';
    
    state = RegistrationModel(
      name: name,
      email: email,
      whatsapp: whatsapp,
      address: address,
    );
  }

  Future<void> saveRegistration(RegistrationModel data) async {
    await prefs.setString(_nameKey, data.name);
    await prefs.setString(_emailKey, data.email);
    await prefs.setString(_whatsappKey, data.whatsapp);
    await prefs.setString(_addressKey, data.address);
    
    state = data;
  }
}

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationModel>((ref) {
  throw UnimplementedError('registrationProvider deve ser injetado no main.dart');
});