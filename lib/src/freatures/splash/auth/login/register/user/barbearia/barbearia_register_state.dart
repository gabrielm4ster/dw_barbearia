enum BarbeariaRegisterStateStatus { initial, success, error }

class BarbeariaRegisterState {
  final BarbeariaRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbeariaRegisterState.initial()
      : this(
          status: BarbeariaRegisterStateStatus.initial,
          openingDays: <String>[],
          openingHours: <int>[],
        );

  BarbeariaRegisterState({
    required this.status,
    required this.openingDays,
    required this.openingHours,
  });

  BarbeariaRegisterState copyWith({
    BarbeariaRegisterStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return BarbeariaRegisterState(
        status: status ?? this.status,
        openingDays: openingDays ?? this.openingDays,
        openingHours: openingHours ?? this.openingHours);
  }
}