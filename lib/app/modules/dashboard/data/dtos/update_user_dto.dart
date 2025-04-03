class UpdateUserDto {
  final double? lastLatitude;
  final double? lastLongitude;
  final double? bearing;

  UpdateUserDto({
    this.lastLatitude,
    this.lastLongitude,
    this.bearing,
  });

  factory UpdateUserDto.fromMap(Map<String, dynamic> json) => UpdateUserDto(
        lastLatitude: json["last_latitude"]?.toDouble(),
        lastLongitude: json["last_longitude"]?.toDouble(),
        bearing: json["bearing"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "last_latitude": lastLatitude,
        "last_longitude": lastLongitude,
        "bearing": bearing,
      }..removeWhere((key, value) => value == null);
}
