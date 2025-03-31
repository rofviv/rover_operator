class FetchOrdersDto {
  final DateTime start;
  final DateTime end;
  final String status;

  FetchOrdersDto({
    required this.start,
    required this.end,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "status": status,
      };
}
