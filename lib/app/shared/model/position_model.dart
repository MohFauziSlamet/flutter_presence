// To parse this JSON data, do
//
//     final positionRes = positionResFromJson(jsonString);

import 'dart:convert';

import 'package:geolocator/geolocator.dart';

PositionModel positionResFromJson(String str) => PositionModel.fromJson(json.decode(str));

String positionResToJson(PositionModel data) => json.encode(data.toJson());

class PositionModel {
  Position? position;
  String? message;
  bool? error;

  PositionModel({
    this.position,
    this.message,
    this.error,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        position: json["position"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "position": position?.toJson(),
        "message": message,
        "error": error,
      };
}
