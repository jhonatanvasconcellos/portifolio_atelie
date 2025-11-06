import 'package:atelie_portifolio/features/home/provider/home_provider.dart';
import 'package:atelie_portifolio/core/models/registration_model.dart';
import 'package:atelie_portifolio/core/providers/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    final currentRegistration = ref.read(registrationProvider);
    _nameController = TextEditingController(text: currentRegistration.name);
    _emailController = TextEditingController(text: currentRegistration.email);
    _whatsappController = TextEditingController(
      text: currentRegistration.whatsapp,
    );
    _addressController = TextEditingController(
      text: currentRegistration.address,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final bool isFirstTimeSave = ref.read(registrationProvider).isEmpty;
    if (_formKey.currentState?.validate() ?? false) {
      final newRegistration = RegistrationModel(
        name: _nameController.text,
        email: _emailController.text,
        whatsapp: _whatsappController.text,
        address: _addressController.text,
      );

     await  ref.read(registrationProvider.notifier).saveRegistration(newRegistration);
     if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      FocusScope.of(context).unfocus();

      if(isFirstTimeSave){
        ref.read(homePageIndexProvider.notifier).state = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome Completo',
              icon: Icon(Icons.person),
            ),
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Por favor, digite seu nome' : null,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Por favor, digite seu email';
              if (!value!.contains('@') || !value.contains('.'))
                return 'Email inválido';
              return null;
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _whatsappController,
            decoration: const InputDecoration(
              labelText: 'WhatsApp (com DDD)',
              icon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) => (value?.isEmpty ?? true)
                ? 'Por favor, digite seu WhatsApp'
                : null,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Endereço Completo (Rua, N°, Bairro, Cidade)',
              icon: Icon(Icons.home),
            ),
            maxLines: 2, 
            validator: (value) => (value?.isEmpty ?? true)
                ? 'Por favor, digite seu endereço'
                : null,
          ),
          const SizedBox(height: 32),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.black, 
              foregroundColor: Colors.white, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _saveForm,
            child: const Text(
              'Salvar Cadastro',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
