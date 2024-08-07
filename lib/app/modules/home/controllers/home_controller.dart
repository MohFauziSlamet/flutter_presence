// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_presensi/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_presensi/app/shared/model/absensi_data_model.dart';
import 'package:flutter_presensi/app/shared/model/position_model.dart';
import 'package:flutter_presensi/app/utils/services/dialog_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  /// dummy data.
  /// empty data in.
  /// empty data out.
  Rx<AbsensiDataModel> user = AbsensiDataModel(
    id: "njhklnjkkk",
    nama: "Moh Fauzi Slamet",
    nip: 12341234,
    job: "programmer",
  ).obs;

  /// dumy data
  AbsensiDataModel history = AbsensiDataModel(
    id: "njhklnjkkk",
    nama: "Moh Fauzi Slamet",
    nip: 12341234,
    job: "programmer",
    keluar: AbsensiData(
      date: DateTime.now().toString(),
      lat: 1222.1222,
      long: 1222.1222,
      address: "Malang, suhat venturo",
      status: "status keluar",
      distance: 100,
    ),
    masuk: AbsensiData(
      date: DateTime.now().toString(),
      lat: 1222.1222,
      long: 1222.1222,
      address: "Malang, suhat venturo",
      status: "status masuk",
      distance: 100,
    ),
  );

  void onTapPresence() async {
    DialogService.showLoading();
    PositionModel? data = await determinePosition();

    log(data?.toJson().toString() ?? "");
    if (data?.position != null) {
      Position position = data!.position!;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      // log(placemarks[0]);

      String address =
          "${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].subAdministrativeArea} , ${placemarks[0].postalCode} - ${placemarks[0].country} ${placemarks[0].isoCountryCode}";

      /// MENCARI JARAK ANTARA 2 POSITION (OFFICE DAN USER )
      double distance = Geolocator.distanceBetween(
        ProfileController.to.lat,
        ProfileController.to.long,
        position.latitude,
        position.longitude,
      );

      DialogService.closeLoading();
      log("message distanse : $distance", name: "distance");

      if (distance <= ProfileController.to.distanceValue.value) {
        /// JIKA JARAK NYA KURANG DARI 200 METER
        /// MAKA STATUS AKAN DIUBAH MENAJADI DI DALAM AREA

        /// if presence in is null
        if (user.value.masuk == null) {
          return _presenceIn(address: address, distance: distance, position: position);
        }

        /// if presence out is null
        if (user.value.keluar == null) {
          return _presenceOut(address: address, distance: distance, position: position);
        }

        /// allready presence
        return _alreadyHasAPresence();
      } else {
        Get.snackbar(
          animationDuration: const Duration(seconds: 2),
          "Terjadi Kesalahan",
          "Anda berada diluar jangkauan radius",
          backgroundColor: Colors.white,
        );
        return;
      }
    } else {
      Get.snackbar(
        animationDuration: const Duration(seconds: 2),
        "Terjadi Kesalahan",
        data?.message ?? "Terjadi Kesalahan",
        backgroundColor: Colors.white,
      );
    }
  }

  void _presenceIn({String? address, double? distance, Position? position}) {
    Get.defaultDialog(
      title: "Validasi",
      middleText: "Apakah kamu yakin akan mengisi daftar hadir ( MASUK ) sekarang?",
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () async {
            DialogService.showLoading();
            user.value.masuk = AbsensiData(
              address: address,
              date: DateTime.now().toIso8601String(),
              distance: distance,
              lat: position?.latitude ?? 0,
              long: position?.longitude ?? 0,
              status: "Didalam Area",
            );
            await Future.delayed(const Duration(milliseconds: 1000));
            DialogService.closeLoading();
            update();

            Get.back();
            Get.snackbar(
              "Berhasil",
              "Kamu telah mengisi daftar hadir ( MASUK )",
              animationDuration: const Duration(seconds: 2),
              backgroundColor: Colors.white,
            );
          },
          child: const Text("YES"),
        ),
      ],
    );
  }

  void _presenceOut({String? address, double? distance, Position? position}) {
    Get.defaultDialog(
      title: "Validasi",
      middleText: "Apakah kamu yakin akan mengisi daftar hadir ( KELUAR ) sekarang?",
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () async {
            DialogService.showLoading();
            user.value.keluar = AbsensiData(
              address: address,
              date: DateTime.now().toIso8601String(),
              distance: distance,
              lat: position?.latitude,
              long: position?.longitude,
              status: "Didalam Area",
            );

            await Future.delayed(const Duration(milliseconds: 1000));
            DialogService.closeLoading();
            update();
            Get.back();
            Get.snackbar(
              "Berhasil",
              "Kamu telah mengisi daftar hadir ( KELUAR )",
              animationDuration: const Duration(seconds: 2),
              backgroundColor: Colors.white,
            );
          },
          child: const Text("YES"),
        ),
      ],
    );
  }

  void _alreadyHasAPresence() {
    Get.defaultDialog(
      title: "Berhasil",
      middleText: "Kamu sudah mengisi daftar hadir untuk hari ini.\nApakah mau melihat detail ?",
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () async {
            /// go to detail
            Get.back();
          },
          child: const Text("YES"),
        ),
      ],
    );
  }

  /// =============== GET LOCATION ===============
  // Determine the current position of the device.
  //  When the location services are not enabled or permissions
  //  are denied the `Future` will return an error.
  Future<PositionModel?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return PositionModel(
        message: "Tidak dapat mengakses GPS pada device ini",
        error: true,
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return PositionModel(
          message: "Izin mengakses GPS ditolak.",
          error: true,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return PositionModel(
        message: "Settingan hp kamu tidak memperbolehkan mengakses GPS. Ubah settingan hp kamu.",
        error: true,
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return PositionModel(
      position: position,
      message: "Berhasil mendapatkan posisi device",
      error: false,
    );
  }
}
