import 'dart:developer';

import 'package:dw_barbearia/src/core/helpers/messages.dart';
import 'package:dw_barbearia/src/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/core/ui/widgets/avatar_widgets.dart';
import 'package:dw_barbearia/src/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbearia/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbearia/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbearia/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);
    final barbeariaAsyncValue = ref.watch(getMyBarbeariaProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          context.showSuccess('Colaborador cadastrado com sucesso');
          Navigator.pop(context);
        case EmployeeRegisterStateStatus.error:
          context.showError('Erro ao registrar colaborador');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: barbeariaAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar a página',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar a página'),
          );
        },
        loading: () => const BarbeariaLoader(),
        data: (barbeariaModel) {
          final BarbeariaModel(:openingDays, :openingHours) = barbeariaModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Checkbox.adaptive(
                              value: registerADM,
                              onChanged: (value) {
                                setState(() {
                                  registerADM = !registerADM;
                                  employeeeRegisterVM
                                      .setRegisterADM(registerADM);
                                });
                              }),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      Offstage(
                        offstage: registerADM,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: nameEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.required('Nome obrigatório'),
                              decoration:
                                  const InputDecoration(label: Text('Nome')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: emailEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'E-mail obrigatório'),
                                      Validatorless.email('E-mail obrigatório')
                                    ]),
                              decoration:
                                  const InputDecoration(label: Text('E-mail')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: passwordEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha Obrigatório'),
                                      Validatorless.min(6,
                                          'Senha deve ter no minimo 6 caracteres'),
                                    ]),
                              decoration:
                                  const InputDecoration(label: Text('Senha')),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      WeekdaysPanel(
                          enabledDays: openingDays,
                          onDayPressed:
                              employeeeRegisterVM.addOrRemoveWorkdays),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPanel(
                          enabledTimes: openingHours,
                          startTime: 6,
                          endTime: 23,
                          onHourPressed:
                              employeeeRegisterVM.addOrRemoveWorkhours),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case null || false:
                              context.showError('Existem campos inválidos');
                            case true:
                              final EmployeeRegisterState(
                                workdays: List(isNotEmpty: hasWorkDays),
                                workhours: List(isNotEmpty: hasWorkHours)
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                context.showError(
                                    'Por favor selecione os dias das semana e horário de atendimento');
                                return;
                              }

                              final name = nameEC.text;
                              final email = emailEC.text;
                              final password = passwordEC.text;

                              employeeeRegisterVM.register(
                                  name: name, email: email, password: password);
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
