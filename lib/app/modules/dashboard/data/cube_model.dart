class CubeStatusModel {
    final String? armadoStr;
    final String? safetyStr;
    final String? mode;
    final double? lat;
    final double? lon;
    final double? alt;
    final double? batteryPercentage;
    final double? roll;
    final double? pitch;
    final double? yaw;
    final Map<String, double>? rcValues;

    CubeStatusModel({
        this.armadoStr,
        this.safetyStr,
        this.mode,
        this.lat,
        this.lon,
        this.alt,
        this.batteryPercentage,
        this.roll,
        this.pitch,
        this.yaw,
        this.rcValues,
    });

    CubeStatusModel copyWith({
        String? armadoStr,
        String? safetyStr,
        String? mode,
        double? lat,
        double? lon,
        double? alt,
        double? batteryPercentage,
        double? roll,
        double? pitch,
        double? yaw,
        Map<String, double>? rcValues,
    }) => 
        CubeStatusModel(
            armadoStr: armadoStr ?? this.armadoStr,
            safetyStr: safetyStr ?? this.safetyStr,
            mode: mode ?? this.mode,
            lat: lat ?? this.lat,
            lon: lon ?? this.lon,
            alt: alt ?? this.alt,
            batteryPercentage: batteryPercentage ?? this.batteryPercentage,
            roll: roll ?? this.roll,
            pitch: pitch ?? this.pitch,
            yaw: yaw ?? this.yaw,
            rcValues: rcValues ?? this.rcValues,
        );

    factory CubeStatusModel.fromJson(Map<String, dynamic> json) => CubeStatusModel(
        armadoStr: json["armado_str"],
        safetyStr: json["safety_str"],
        mode: json["mode"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        alt: json["alt"]?.toDouble(),
        batteryPercentage: json["battery_percentage"]?.toDouble(),
        roll: json["roll"]?.toDouble(),
        pitch: json["pitch"]?.toDouble(),
        yaw: json["yaw"]?.toDouble(),
        rcValues: Map.from(json["rc_values"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "armado_str": armadoStr,
        "safety_str": safetyStr,
        "mode": mode,
        "lat": lat,
        "lon": lon,
        "alt": alt,
        "battery_percentage": batteryPercentage,
        "roll": roll,
        "pitch": pitch,
        "yaw": yaw,
        "rc_values": Map.from(rcValues!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
