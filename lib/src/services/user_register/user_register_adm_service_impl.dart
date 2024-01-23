import 'package:dw_barbearia/src/core/core/core/ui/exceptions/service_exption.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';
import 'package:dw_barbearia/src/freatures/splash/auth/login/register/user/user_repository.dart';
import 'package:dw_barbearia/src/services/user_login_service.dart';
import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserRegisterAdmServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    
    final registerResult = await userRepository.registerAdmin(userData);

    switch(registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}