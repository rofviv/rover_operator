class ZoneModel {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final int coverageId;
  final int coverageReportId;

  ZoneModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.coverageId,
    required this.coverageReportId,
  });

  factory ZoneModel.fromMap(Map<String, dynamic> json) => ZoneModel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        coverageId: json["coverage_id"],
        coverageReportId: json["coverage_report_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "coverage_id": coverageId,
        "coverage_report_id": coverageReportId,
      };

  static List<ZoneModel> fromList(List list) =>
      list.map((e) => ZoneModel.fromMap(e)).toList();
}
