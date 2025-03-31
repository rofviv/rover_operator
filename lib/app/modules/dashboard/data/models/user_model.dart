class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? status;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.status,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? status,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        status: status ?? this.status,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "status": status,
      };
}
