import 'package:dw_barbearia/src/core/exceptions/service_exption.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/fp/nil.dart';

abstract interface class UserRegisterAdmService {
  Future<Either<ServiceException, Nil>> execute(
      ({String name, String email, String password}) userData);
}
