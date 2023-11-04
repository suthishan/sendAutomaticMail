const String tableNotes = 'notes';

class TransactionDetails {
  static final List<String> values = [
    /// Add all fields
    id, description, status, time
  ];

  static const String id = 'id';
  static const String description = 'description';
  static const String status = 'status';
  static const String time = 'time';
}

class TransactionDetail {
  final int id;
  final String description;
  final String status;
  final DateTime time;

  TransactionDetail({
    required this.id,
    required this.description,
    required this.status,
    required this.time,
  });

  TransactionDetail copy({
    int? id,
    String? description,
    String? status,
    DateTime? time,
  }) =>
      TransactionDetail(
        id: id ?? this.id,
        status: status ?? this.status,
        description: description ?? this.description,
        time: time ?? this.time,
      );

  static TransactionDetail fromJson(Map<String, Object?> json) =>
      TransactionDetail(
        id: json[TransactionDetails.id] as int,
        status: json[TransactionDetails.status] as String,
        description: json[TransactionDetails.description] as String,
        time: DateTime.parse(json[TransactionDetails.time] as String),
      );

  Map<String, Object?> toJson() => {
        TransactionDetails.id: id,
        TransactionDetails.status: status,
        TransactionDetails.description: description,
        TransactionDetails.time: time.toIso8601String(),
      };
}
