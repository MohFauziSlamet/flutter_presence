// To parse this JSON data, do
//
//     final absensiDataModel = absensiDataModelFromJson(jsonString);

import 'dart:convert';

AbsensiDataModel absensiDataModelFromJson(String str) =>
    AbsensiDataModel.fromJson(json.decode(str));

String absensiDataModelToJson(AbsensiDataModel data) => json.encode(data.toJson());

class AbsensiDataModel {
  String? id;
  String? nama;
  int? nip;
  String? job;
  AbsensiData? keluar;
  AbsensiData? masuk;

  AbsensiDataModel({
    this.id,
    this.nama,
    this.nip,
    this.job,
    this.keluar,
    this.masuk,
  });

  factory AbsensiDataModel.fromJson(Map<String, dynamic> json) => AbsensiDataModel(
        id: json["id"],
        nama: json["nama"],
        nip: json["nip"],
        job: json["job"],
        keluar: json["keluar"] == null ? null : AbsensiData.fromJson(json["keluar"]),
        masuk: json["masuk"] == null ? null : AbsensiData.fromJson(json["masuk"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nip": nip,
        "job": job,
        "keluar": keluar?.toJson(),
        "masuk": masuk?.toJson(),
      };
}

class AbsensiData {
  String? date;
  double? lat;
  double? long;
  String? address;
  String? status;
  double? distance;

  AbsensiData({
    this.date,
    this.lat,
    this.long,
    this.address,
    this.status,
    this.distance,
  });

  factory AbsensiData.fromJson(Map<String, dynamic> json) => AbsensiData(
        date: json["date"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        address: json["address"],
        status: json["status"],
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "lat": lat,
        "long": long,
        "address": address,
        "status": status,
        "distance": distance,
      };
}
