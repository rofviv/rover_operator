class UserModel {
  final int id;
  final String? name;
  final String? email;
  final String? status;
  final int modalityId;
  final int cityId;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.status,
    required this.modalityId,
    required this.cityId,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? status,
    int? modalityId,
    int? cityId,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        status: status ?? this.status,
        modalityId: modalityId ?? this.modalityId,
        cityId: cityId ?? this.cityId,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
        modalityId: json["modalityId"] ?? 1,
        cityId: json["city_id"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "status": status,
        "modalityId": modalityId,
        "city_id": cityId,
      };
}
