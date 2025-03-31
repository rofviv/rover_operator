class RelayModel {
  final String? status;
  final int? relay1;
  final int? relay2;
  final int? relay3;
  final int? relay4;
  final int? relay5;
  final int? relay6;
  final int? relay7;
  final int? relay8;
  final String? ssid;

  RelayModel({
    this.status,
    this.relay1,
    this.relay2,
    this.relay3,
    this.relay4,
    this.relay5,
    this.relay6,
    this.relay7,
    this.relay8,
    this.ssid,
  });

  factory RelayModel.fromMap(Map<String, dynamic> json) => RelayModel(
        status: json["status"],
        relay1: json["relay1"],
        relay2: json["relay2"],
        relay3: json["relay3"],
        relay4: json["relay4"],
        relay5: json["relay5"],
        relay6: json["relay6"],
        relay7: json["relay7"],
        relay8: json["relay8"],
        ssid: json["ssid"],
      );
}
