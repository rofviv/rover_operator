class FetchOrdersDto {
  final DateTime? start;
  final DateTime? end;
  final String status;

  FetchOrdersDto({
    this.start,
    this.end,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "status": status,
      }..removeWhere((key, value) => value == null);
}
