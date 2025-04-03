class UpdateOrderDto {
  final int? doorNumber;
  final int? pickedUp;

  UpdateOrderDto({
    this.doorNumber,
    this.pickedUp,
  });

  factory UpdateOrderDto.fromMap(Map<String, dynamic> json) => UpdateOrderDto(
        doorNumber: json["doorNumber"],
        pickedUp: json["pickedUp"],
      );

  Map<String, dynamic> toMap() => {
        "doorNumber": doorNumber,
        "pickedUp": pickedUp,
      }..removeWhere((key, value) => value == null);
}
