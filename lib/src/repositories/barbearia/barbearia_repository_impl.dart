import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/fp/nil.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:dw_barbearia/src/repositories/barbearia/barbearia_repository.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';
import '../../core/restClient/rest_client.dart';

class BarbeariaRepositoryImpl implements BarbeariaRepository {
  final RestClient _restClient;

  BarbeariaRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<RepositoryExecption, BarbeariaModel>> getMyBarbearia(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await _restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': "#userAuthRef"},
        );
        return Success(BarbeariaModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) =
            await _restClient.auth.get('/barbershop/${userModel.barbeariaId}');
        return Success(BarbeariaModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryExecption, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours,
      }) data) async {
    try {
      await _restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar barbearia', error: e, stackTrace: s);
      return Failure(
          RepositoryExecption(message: 'Erro ao registrar barbearia'));
    }
  }
}
