class DriverTimingModel {
  int driverTimingId;
  int timingId;
  String status;
  DateTime startTiming;
  DateTime endTiming;
  int zoneId;
  String zone;
  double? zoneLatitude;
  double? zoneLongitude;
  double zoneRadius;

  DriverTimingModel({
    required this.driverTimingId,
    required this.timingId,
    required this.status,
    required this.startTiming,
    required this.endTiming,
    required this.zoneId,
    required this.zone,
    required this.zoneLatitude,
    required this.zoneLongitude,
    required this.zoneRadius,
  });

  factory DriverTimingModel.fromJson(Map map) => DriverTimingModel(
        driverTimingId: map["driver_timing_id"],
        timingId: map["timing_id"],
        status: map["status"],
        startTiming: DateTime.parse(map["start_timing"]),
        endTiming: DateTime.parse(map["end_timing"]),
        zoneId: map["zone_id"],
        zone: map["zone"],
        zoneLatitude: map["zoneLatitude"] ?? 0,
        zoneLongitude: map["zoneLongitude"] ?? 0,
        zoneRadius: map["zoneRadius"]?.toDouble() ?? 500,
      );

  static List<DriverTimingModel> fromList(List list) =>
      list.map((e) => DriverTimingModel.fromJson(e)).toList();
}
