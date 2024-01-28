import 'package:dw_barbearia/src/core/helpers/form_helper.dart';
import 'package:dw_barbearia/src/core/helpers/messages.dart';
import 'package:dw_barbearia/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbearia/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbearia/src/features/auth/register/barbearia/barbearia_register_state.dart';
import 'package:dw_barbearia/src/features/auth/register/barbearia/barbearia_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbeariaRegisterPage extends ConsumerStatefulWidget {
  const BarbeariaRegisterPage({super.key});

  @override
  ConsumerState<BarbeariaRegisterPage> createState() =>
      _BarbeariaRegisterPageState();
}

class _BarbeariaRegisterPageState extends ConsumerState<BarbeariaRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbeariaRegisterVM = ref.watch(barbeariaRegisterVmProvider.notifier);

    ref.listen(barbeariaRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbeariaRegisterStateStatus.initial:
          break;
        case BarbeariaRegisterStateStatus.error:
          context.showError('Desculpe ocorreu um erro ao registrar barbearia');
        case BarbeariaRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cradastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: nameEC,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(height: 22),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: emailEC,
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail obrigatório'),
                  Validatorless.email('E-mail obrigatório')
                ]),
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              const SizedBox(height: 24),
              WeekdaysPanel(
                onDayPressed: (String value) {
                  barbeariaRegisterVM.addOrRemoveOpenDay(value);
                },
              ),
              const SizedBox(height: 24),
              HoursPanel(
                startTime: 6,
                endTime: 23,
                onHourPressed: (int value) {
                  barbeariaRegisterVM.addOrRemoveOpenHour(value);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56)),
                onPressed: () {
                  switch (formKey.currentState?.validate()) {
                    case null || false:
                      context.showError('Formulário invalido');
                    case true:
                      barbeariaRegisterVM.register(
                        name: nameEC.text,
                        email: emailEC.text,
                      );
                  }
                },
                child: const Text('CADASTRAR ESTABELECIMENTO'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
