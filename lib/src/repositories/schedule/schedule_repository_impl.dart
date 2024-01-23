import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/nil.dart';
import 'package:dw_barbearia/src/core/restClient/rest_client.dart';
import 'package:dw_barbearia/src/model/schedule_model.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient _restClient;

  ScheduleRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<RepositoryExecption, Nil>> scheduleClient(
      ({
        int barbeariad,
        String clientName,
        DateTime date,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await _restClient.auth.post(
        '/schedules',
        data: {
          'barbearia_id': scheduleData.barbeariad,
          'user_id': scheduleData.userId,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryExecption(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryExecption, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date,
        int userId,
      }) filter) async {
    try {
      final Response(:List data) =
          await _restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });
      final schedules = data.map((res) => ScheduleModel.fromMap(res)).toList();
      return Success(schedules);
    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos de uma data', error: e, stackTrace: s);
      return Failure(RepositoryExecption(
          message: 'Erro ao buscar agendamentos de uma data'));
    } on ArgumentError catch (e, s) {
      log('Json Invalido', error: e, stackTrace: s);
      return Failure(RepositoryExecption(message: 'Json Invalido'));
    }
  }

  @override
  Future<Either<RepositoryExecption, Nil>> sheduleClient(
      ({
        int barbeariaId,
        String clientName,
        DateTime date,
        int time,
        int userId
      }) scheduleData) {
    // TODO: implement sheduleClient
    throw UnimplementedError();
  }
}
