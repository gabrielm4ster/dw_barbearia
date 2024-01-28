import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/fp/nil.dart';
import 'package:dw_barbearia/src/model/schedule_model.dart';
import 'package:dw_barbearia/src/repositories/repository_exception.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryExecption, Nil>> scheduleClient(
      ({
        int barbeariaId,
        int userId,
        String clientName,
        DateTime date,
        int time,
      }) scheduleData);

  Future<Either<RepositoryExecption, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date,
        int userId,
      }) filter);
}
