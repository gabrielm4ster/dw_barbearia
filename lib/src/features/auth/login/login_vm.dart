import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/exceptions/service_exption.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/features/auth/login/login_state.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHendle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        //! Invalidando os caches para evitar o Login com o usuário errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbeariaProvider);

        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
            status: LoginStateStatus.error, errorMessage: () => message);
    }
    loaderHendle.close();
  }
}
