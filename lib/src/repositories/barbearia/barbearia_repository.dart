import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';

abstract interface class BarbeariaRepository {
  Future<Either<RepositoryExecption, BarbeariaModel>> getMyBarbearia(UserModel userModel);

  Future<Either<RepositoryExecption, Nil>> save(({
    String name, 
    String email,
    List<String> openingDays,
    List<int> openingHours,
  }) data);
  
}