import 'package:dw_barbearia/src/core/exceptions/auth_exeptions.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/fp/nil.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';

abstract interface class UserRepository {
  Future<Either<AuthExecption, String>> login(String email, String password);

  Future<Either<RepositoryExecption, UserModel>> me();

  Future<Either<RepositoryExecption, Nil>> registerAdmin(
    ({String name, String email, String password}) userData,
  );

  Future<Either<RepositoryExecption, List<UserModel>>> getEmployees(
      int barbeariaId);

  Future<Either<RepositoryExecption, Nil>> registerAdmAsEmployee(
      ({
        List<String> workDays,
        List<int> workHours,
      }) userModel);

  Future<Either<RepositoryExecption, Nil>> registerEmployee(
      ({
        int barbeariaId,
        String name,
        String email,
        String password,
        List<String> workDays,
        List<int> workHours,
      }) userModel);
}
