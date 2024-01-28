import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/core/core/ui/fp/either.dart';
import 'package:dw_barbearia/src/core/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/freatures/employee/register/schedule/schedule_state.dart';
import 'package:dw_barbearia/src/model/barbearia_model.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int hour) {
    if (hour == state.scheduleTime) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void deteSelecte(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleTime) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final BarbeariaModel(id: barbeariaId) =
        await ref.watch(getMyBarbeariaProvider.future);

    final dto = (
      barbeariaId: barbeariaId,
      userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleTime!,
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch (scheduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
