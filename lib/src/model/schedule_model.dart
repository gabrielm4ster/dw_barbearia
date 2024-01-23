class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.barbeariaId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.hour,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'barbearia_id': int barbeariaId,
          'user_id': int userId,
          'client_name': String clientName,
          'date': String scheduleDate,
          'time': int hour,
        }:
        return ScheduleModel(
          id: id,
          barbeariaId: barbeariaId,
          userId: userId,
          clientName: clientName,
          date: DateTime.parse(scheduleDate),
          hour: hour,
        );
      case _:
        throw ArgumentError('Invalid JSON: $json');
    }
  }

  final int id, barbeariaId, userId, hour;
  final String clientName;
  final DateTime date;
}