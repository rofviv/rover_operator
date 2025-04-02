class CreateTimingDto {
  final DateTime startTiming;
  final DateTime endTiming;
  final int limitTiming;
  final int modalityId;
  final int zoneId;
  final int extraAmount;
  final int bonus;
  final int userId;
  final String description;

  CreateTimingDto({
    required this.startTiming,
    required this.endTiming,
    required this.limitTiming,
    required this.modalityId,
    required this.zoneId,
    required this.extraAmount,
    required this.bonus,
    required this.userId,
    required this.description,
  });

  factory CreateTimingDto.fromMap(Map<String, dynamic> json) => CreateTimingDto(
        startTiming: DateTime.parse(json["start_timing"]),
        endTiming: DateTime.parse(json["end_timing"]),
        limitTiming: json["limit_timing"],
        modalityId: json["modality_id"],
        zoneId: json["zone_id"],
        extraAmount: json["extraAmount"],
        bonus: json["bonus"],
        userId: json["user_id"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "start_timing": startTiming.toUtc().toIso8601String(),
        "end_timing": endTiming.toUtc().toIso8601String(),
        "limit_timing": limitTiming,
        "modality_id": modalityId,
        "zone_id": zoneId,
        "extraAmount": extraAmount,
        "bonus": bonus,
        "user_id": userId,
        "description": description,
      };
}
