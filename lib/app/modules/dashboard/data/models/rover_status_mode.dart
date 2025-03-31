class RoverStatusModel {
  final bool? success;
  final String? message;
  final String? ipRelay;
  final String? token;
  final String? latencyStatus;
  final String? lidarStatus;
  final String? sonarBackStatus;
  final String? sonarFrontStatus;
  final String? sonarBackDistance;
  final String? sonarFrontDistance;
  final String? lidarDistance;
  final String? lidarAngle;
  final String? latencyTime;

  RoverStatusModel({
    this.success,
    this.message,
    this.ipRelay,
    this.token,
    this.latencyStatus,
    this.lidarStatus,
    this.sonarBackStatus,
    this.sonarFrontStatus,
    this.sonarBackDistance,
    this.sonarFrontDistance,
    this.lidarDistance,
    this.lidarAngle,
    this.latencyTime,
  });

  RoverStatusModel copyWith({
    bool? success,
    String? message,
    String? ipRelay,
    String? token,
    String? latencyStatus,
    String? lidarStatus,
    String? sonarBackStatus,
    String? sonarFrontStatus,
    String? sonarBackDistance,
    String? sonarFrontDistance,
    String? lidarDistance,
    String? lidarAngle,
    String? latencyTime,
  }) =>
      RoverStatusModel(
        success: success ?? this.success,
        message: message ?? this.message,
        ipRelay: ipRelay ?? this.ipRelay,
        token: token ?? this.token,
        latencyStatus: latencyStatus ?? this.latencyStatus,
        lidarStatus: lidarStatus ?? this.lidarStatus,
        sonarBackStatus: sonarBackStatus ?? this.sonarBackStatus,
        sonarFrontStatus: sonarFrontStatus ?? this.sonarFrontStatus,
        sonarBackDistance: sonarBackDistance ?? this.sonarBackDistance,
        sonarFrontDistance: sonarFrontDistance ?? this.sonarFrontDistance,
        lidarDistance: lidarDistance ?? this.lidarDistance,
        lidarAngle: lidarAngle ?? this.lidarAngle,
        latencyTime: latencyTime ?? this.latencyTime,
      );

  factory RoverStatusModel.fromJson(Map<String, dynamic> json) =>
      RoverStatusModel(
        success: json["success"],
        message: json["message"],
        ipRelay: json["ip_relay"],
        token: json["token"],
        latencyStatus: json["latency_status"],
        lidarStatus: json["lidar_status"],
        sonarBackStatus: json["sonar_back_status"],
        sonarFrontStatus: json["sonar_front_status"],
        sonarBackDistance: json["sonar_back_distance"],
        sonarFrontDistance: json["sonar_front_distance"],
        lidarDistance: json["lidar_distance"],
        lidarAngle: json["lidar_angle"],
        latencyTime: json["latency_time"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "ip_relay": ipRelay,
        "token": token,
        "latency_status": latencyStatus,
        "lidar_status": lidarStatus,
        "sonar_back_status": sonarBackStatus,
        "sonar_front_status": sonarFrontStatus,
        "sonar_back_distance": sonarBackDistance,
        "sonar_front_distance": sonarFrontDistance,
        "lidar_distance": lidarDistance,
        "lidar_angle": lidarAngle,
        "latency_time": latencyTime,
      };
}
