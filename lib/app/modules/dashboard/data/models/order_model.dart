import 'dart:convert';

import 'package:flutter/material.dart';

class Order {
  Order({
    required this.id,
    required this.fromAddress,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toAddress,
    required this.toLatitude,
    required this.toLongitude,
    required this.metersEstimatedDistance,
    required this.phoneUser,
    required this.nameUser,
    required this.status,
    required this.tip,
    required this.total,
    required this.discount,
    required this.merchantId,
    required this.cityId,
    required this.createdAt,
    required this.paymentModeId,
    required this.details,
    required this.userId,
    required this.comment,
    required this.instructions,
    required this.driverOrderId,
    required this.merchantName,
    required this.orderReadyAt,
    required this.urlImageReference,
    this.isConfirmOrder,
    this.baseCost = 0,
    this.businessName,
    this.nit,
    this.feeMerchant = 0,
    this.pickupUp = 0,
    this.dropoffArrived = 0,
    this.doorNumber = 1,
    this.color = Colors.black,
  });

  final int id;
  final String fromAddress;
  final double fromLatitude;
  final double fromLongitude;
  final String toAddress;
  final double toLatitude;
  final double toLongitude;
  double metersEstimatedDistance;
  final String phoneUser;
  final String nameUser;
  String status;
  double tip;
  double total;
  final double discount;
  final String? merchantId;
  final int cityId;
  final DateTime createdAt;
  final int paymentModeId;
  final List<Product>? details;
  final int userId;
  final String? comment;
  final String? instructions;
  final int driverOrderId;
  final String? merchantName;
  DateTime? orderReadyAt;
  final String? urlImageReference;
  final int? isConfirmOrder;
  final double baseCost;
  final String? businessName;
  final String? nit;
  final double feeMerchant;
  final int pickupUp;
  final int dropoffArrived;
  final int doorNumber;
  Color color;

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: map["id"],
        fromAddress: map["from_address"],
        fromLatitude: map["from_latitude"].toDouble(),
        fromLongitude: map["from_longitude"].toDouble(),
        toAddress: map["to_address"],
        toLatitude: map["to_latitude"].toDouble(),
        toLongitude: map["to_longitude"].toDouble(),
        metersEstimatedDistance: map["meters_estimated_distance"].toDouble(),
        phoneUser: map["phone_user"],
        nameUser: map["name_user"],
        status: map["status"],
        tip: map["tip"]?.toDouble() ?? 0,
        total: map["total"]?.toDouble() ?? 0,
        discount: map["discount"]?.toDouble() ?? 0,
        merchantId: map["merchant_id"]?.toString(),
        cityId: map["city_id"],
        createdAt: DateTime.parse(map["createdAt"]),
        paymentModeId: map["paymentModeId"] ?? map["payment_mode_id"],
        details: map['details'] != null
            ? Product.fromList(json.decode(map['details']))
            : null,
        userId: map["user_id"] ?? map["userId"],
        comment: map["comment"],
        instructions: map["instructions"],
        driverOrderId: map["driverOrderId"] ?? 0,
        merchantName: map["storeName"] ?? map["merchantName"],
        orderReadyAt:
            map["order_ready_at"] == null && map["orderReadyAt"] == null
                ? null
                : DateTime.parse(map["order_ready_at"] ?? map["orderReadyAt"]),
        urlImageReference: map["url_image_reference"],
        isConfirmOrder: map["isConfirmOrder"],
        baseCost:
            map["baseCost"]?.toDouble() ?? map["base_cost"]?.toDouble() ?? 0,
        businessName: map["business_name"] ?? map["businessName"],
        nit: map["nit"],
        feeMerchant: map["fee_merchant"]?.toDouble() ?? 0,
        pickupUp: map["picked_up"] ?? 0,
        dropoffArrived: map["dropoff_arrived"] ?? 0,
        doorNumber: map["door_number"] ?? 1,
        color: Colors.black,
      );

  static Color getColorRandom(int colorIndex) {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];

    return colors[colorIndex];
  }

  static List<Order> fromList(List list) =>
      list.map((e) => Order.fromMap(e)).toList();
}

class Product {
  Product({
    this.quantity,
    this.price,
    this.productId,
    this.toppings,
    this.name,
    this.description,
    this.notes,
  });

  int? quantity;
  double? price;
  int? productId;
  List<DetailTopping>? toppings;
  String? name;
  String? description;
  String? notes;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        productId: json["productId"],
        toppings: json["toppings"] == null
            ? []
            : List<DetailTopping>.from(
                json["toppings"]!.map((x) => DetailTopping.fromJson(x))),
        name: json["name"],
        description: json["description"],
        notes: json["notes"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "price": price,
        "productId": productId,
        "toppings": toppings == null
            ? []
            : List<dynamic>.from(toppings!.map((x) => x.toJson())),
        "name": name,
        "description": description,
        "notes": notes,
      };

  static List<Map<String, dynamic>> toJsonList(List<Product> list) =>
      list.map((e) => e.toMap()).toList();

  static List<Product> fromList(List list) =>
      list.map((e) => Product.fromMap(e)).toList();
}

class DetailTopping {
  int? toppingId;
  int? subToppingId;
  String? toppingName;
  String? subToppingName;
  int? quantity;
  double? price;

  DetailTopping({
    this.toppingId,
    this.subToppingId,
    this.toppingName,
    this.subToppingName,
    this.quantity,
    this.price,
  });

  DetailTopping copyWith({
    int? toppingId,
    int? subToppingId,
    String? toppingName,
    String? subToppingName,
    int? quantity,
    double? price,
  }) =>
      DetailTopping(
        toppingId: toppingId ?? this.toppingId,
        subToppingId: subToppingId ?? this.subToppingId,
        toppingName: toppingName ?? this.toppingName,
        subToppingName: subToppingName ?? this.subToppingName,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  factory DetailTopping.fromJson(Map<String, dynamic> json) => DetailTopping(
        toppingId: json["toppingId"],
        subToppingId: json["subToppingId"],
        toppingName: json["toppingName"],
        subToppingName: json["subToppingName"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "toppingId": toppingId,
        "subToppingId": subToppingId,
        "toppingName": toppingName,
        "subToppingName": subToppingName,
        "quantity": quantity,
        "price": price,
      };
}
