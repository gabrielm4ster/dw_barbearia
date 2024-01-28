// ignore_for_file: unused_local_variable

import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';
import 'package:dw_barbearia/src/core/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbearia/src/features/splash/auth/login/register/user/user_repository.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterADM(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrRemoveWorkdays(String weekDay) {
    final EmployeeRegisterState(:workdays) = state;

    if (workdays.contains(weekDay)) {
      workdays.remove(weekDay);
    } else {
      workdays.add(weekDay);
    }

    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkhours(int hour) {
    final EmployeeRegisterState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }

    state = state.copyWith(workhours: workhours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerADM, :workdays, :workhours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdmAsEmployee, :registerEmployee) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryExecption, Nil> resultRegister;

    if (registerADM) {
      final dto = (workDays: workdays, workHours: workhours);
      resultRegister = await registerAdmAsEmployee(dto);
    } else {
      final BarbeariaModel(:id) =
          await ref.watch(getMyBarbeariaProvider.future);
      final dto = (
        barbeariaId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workdays,
        workHours: workhours
      );
      resultRegister = await registerEmployee(dto);
    }

    switch (resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }
}
