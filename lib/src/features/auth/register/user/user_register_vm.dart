import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/features/auth/register/user/user_register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final registerResult = await userRegisterAdmService.execute(userData);
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
