import 'package:dw_barbearia/src/core/barbearia_nav_global_key.dart';
import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/restClient/rest_client.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:dw_barbearia/src/repositories/user/user_repository.dart';
import 'package:dw_barbearia/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbearia/src/repositories/barbearia/barbearia_repository.dart';
import 'package:dw_barbearia/src/repositories/barbearia/barbearia_repository_impl.dart';
import 'package:dw_barbearia/src/repositories/schedule/schedule_repository.dart';
import 'package:dw_barbearia/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:dw_barbearia/src/services/user_login/user_login_service.dart';
import 'package:dw_barbearia/src/services/user_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbeariaRepository barbeariaRepository(BarbeariaRepositoryRef ref) =>
    BarbeariaRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbeariaModel> getMyBarbearia(GetMyBarbeariaRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbeariaRepository = ref.watch(barbeariaRepositoryProvider);
  final result = await barbeariaRepository.getMyBarbearia(userModel);

  return switch (result) {
    Success(value: final barbearia) => barbearia,
    Failure(:final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbeariaProvider);
  Navigator.of(BarbeariaNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.read(restClientProvider));
