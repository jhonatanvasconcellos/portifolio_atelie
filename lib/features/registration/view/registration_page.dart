import 'dart:convert';
import 'package:atelie_portifolio/core/models/registration_model.dart';
import 'package:atelie_portifolio/core/providers/registration_provider.dart';
import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/core/theme/app_spacing.dart';
import 'package:atelie_portifolio/core/theme/app_typography.dart';
import 'package:atelie_portifolio/features/home/provider/home_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; 

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _cepController;
  late final TextEditingController _ruaController;
  late final TextEditingController _numeroController;
  late final TextEditingController _bairroController;
  late final TextEditingController _cidadeController;

  late RegistrationModel _initialData;
  
  bool _isSearchingCep = false;

  @override
  void initState() {
    super.initState();
    _initialData = ref.read(registrationProvider);
    
    _nameController = TextEditingController(text: _initialData.name);
    _whatsappController = TextEditingController(text: _initialData.whatsapp);
    _cepController = TextEditingController(text: _initialData.cep);
    _ruaController = TextEditingController(text: _initialData.rua);
    _numeroController = TextEditingController(text: _initialData.numero);
    _bairroController = TextEditingController(text: _initialData.bairro);
    _cidadeController = TextEditingController(text: _initialData.cidade);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _whatsappController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final bool isFirstTimeSave = _initialData.isEmpty;

    final newRegistration = RegistrationModel(
      name: _nameController.text,
      whatsapp: _whatsappController.text,
      cep: _cepController.text,
      rua: _ruaController.text,
      numero: _numeroController.text,
      bairro: _bairroController.text,
      cidade: _cidadeController.text,
    );

    if (newRegistration == _initialData) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nenhuma alteração detectada.',
            textAlign: TextAlign.center,
            style: AppTypography.button,
          ),
          backgroundColor: Colors.grey[600],
        ),
      );
      FocusScope.of(context).unfocus();
      return;
    }

    await ref.read(registrationProvider.notifier).saveRegistration(newRegistration);
    _initialData = newRegistration; 

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFirstTimeSave ? 'Cadastro salvo com sucesso!' : 'Alteração feita com sucesso!',
          textAlign: TextAlign.center,
          style: AppTypography.button,
        ),
        backgroundColor: AppColors.success,
      ),
    );
    
    FocusScope.of(context).unfocus();
    ref.read(homePageIndexProvider.notifier).state = 0; 
  }

  // Search CEP function
  Future<void> _buscarCep() async {
    final cep = _cepController.text.replaceAll(RegExp(r'[^0-9]'), ''); 
    if (cep.length != 8) {
      return;
    }

    setState(() { _isSearchingCep = true; });

    try {
      final uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        
        if (data.containsKey('erro')) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CEP $cep não encontrado.', textAlign: TextAlign.center)),
          );
        } else {
          // Success
          _ruaController.text = data['logradouro'] ?? '';
          _bairroController.text = data['bairro'] ?? '';
          _cidadeController.text = data['localidade'] ?? '';
        }
      }
    } catch (e) {
      // Erro de internet, etc.
      if (kDebugMode) print(e);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar CEP. Tente novamente.', textAlign: TextAlign.center)),
      );
    }

    setState(() { _isSearchingCep = false; }); 
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        children: [
          // User Info Section
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome Completo',
              icon: Icon(Icons.person),
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite seu nome' : null,
          ),
          AppSpacing.vertical16,
          TextFormField(
            controller: _whatsappController,
            decoration: const InputDecoration(
              labelText: 'WhatsApp (com DDD)',
              icon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite seu WhatsApp' : null,
          ),
          
          AppSpacing.vertical32,

          // Adress Section
          Text(
            'Endereço de envio',
            style: AppTypography.headlineSmall.copyWith(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary, 
            ),
          ),
          AppSpacing.vertical16,

          TextFormField(
            controller: _cepController,
            decoration: InputDecoration(
              labelText: 'CEP',
              icon: const Icon(Icons.location_pin),
              suffixIcon: _isSearchingCep
                  ? const Padding(
                      padding: EdgeInsets.all(AppSpacing.space8),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton( 
                      icon: const Icon(Icons.search),
                      onPressed: _buscarCep,
                    ),
            ),
            keyboardType: TextInputType.number,
            maxLength: 8,
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite seu CEP' : null,
          ),
          AppSpacing.vertical16,

          TextFormField(
            controller: _ruaController,
            decoration: const InputDecoration(
              labelText: 'Rua / Logradouro',
              icon: Icon(Icons.signpost),
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite sua rua' : null,
          ),
          AppSpacing.vertical16,

          TextFormField(
            controller: _numeroController,
            decoration: const InputDecoration(
              labelText: 'Nº',
              icon: Icon(Icons.looks_one),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite o número' : null,
          ),
          AppSpacing.vertical16,

          TextFormField(
            controller: _bairroController,
            decoration: const InputDecoration(
              labelText: 'Bairro',
              icon: Icon(Icons.holiday_village_outlined),
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite seu bairro' : null,
          ),
          AppSpacing.vertical16,

          TextFormField(
            controller: _cidadeController,
            decoration: const InputDecoration(
              labelText: 'Cidade',
              icon: Icon(Icons.location_city),
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Por favor, digite sua cidade' : null,
          ),
          AppSpacing.vertical32,
          
          // Save Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.space16),
              backgroundColor: AppColors.dark,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.space12),
              ),
            ),
            onPressed: _saveForm,
            child: Text(
              'Salvar Cadastro',
              style: AppTypography.button,
            ),
          ),
        ],
      ),
    );
  }
}