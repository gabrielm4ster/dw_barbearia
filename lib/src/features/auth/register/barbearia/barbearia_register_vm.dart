import 'package:dw_barbearia/src/core/fp/either.dart';
import 'package:dw_barbearia/src/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/features/auth/register/barbearia/barbearia_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbearia_register_vm.g.dart';

@riverpod
class BarbeariaRegisterVm extends _$BarbeariaRegisterVm {
  @override
  BarbeariaRegisterState build() => BarbeariaRegisterState.initial();

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;
    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;
    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register({required String name, required String email}) async {
    final repository = ref.watch(barbeariaRepositoryProvider);

    final BarbeariaRegisterState(:openingDays, :openingHours) = state;

    final dto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );

    final registerResult = await repository.save(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMyBarbeariaProvider);
        state = state.copyWith(status: BarbeariaRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: BarbeariaRegisterStateStatus.error);
    }
  }
}
