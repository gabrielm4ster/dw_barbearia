import 'package:dw_barbearia/src/core/core/core/ui/exceptions/service_exption.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
