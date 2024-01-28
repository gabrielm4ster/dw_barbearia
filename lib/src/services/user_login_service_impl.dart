// ignore_for_file: unused_field, unused_local_variable

import 'package:dw_barbearia/src/core/core/core/ui/exceptions/auth_exeptions.dart';
import 'package:dw_barbearia/src/core/core/core/ui/exceptions/service_exption.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';
import 'package:dw_barbearia/src/core/core/local_storage_keys.dart';
import 'package:dw_barbearia/src/features/splash/auth/login/register/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository _userRepository;

  UserLoginServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await _userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKey.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erorr ao realizar login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou Senha Inválidos')),
        };
    }
  }
}
