import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_presensi/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_presensi/app/shared/widget/button/custom_button_widget.dart';
import 'package:flutter_presensi/app/utils/services/dialog_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  /// nilai default
  double lat = -8.1542822;
  double long = 112.4748638;

  RxDouble distanceBetween = RxDouble(1);
  RxDouble distanceValue = RxDouble(100);

  /// LOGOUT
  void logOut() async {
    DialogService.showDrawerUnderConstruction();
  }

  /// UPDATE PASSWORD
  void updatePassword() async {
    DialogService.showDrawerUnderConstruction();
  }

  /// UPDATE PROFILE
  void updateProfile() async {
    DialogService.showDrawerUnderConstruction();
  }

  /// SETTING PROFILE
  void setting() async {
    final formKey = GlobalKey<FormState>();
    DialogService.showDrawerGeneral(
        content: Column(
      children: [
        ListTile(
          splashColor: Colors.blueAccent,
          leading: const Icon(Icons.location_on_outlined),
          title: const Text("Set Latitude Longitude"),
          onTap: () {
            Get.back();
            DialogService.showDrawerGeneral(
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: latitude,
                        decoration: const InputDecoration(
                          hintText: "latitude",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        // keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*([.,]\d*)?$')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a latitude';
                          }
                          final double? latitude = double.tryParse(value.replaceAll(',', '.'));
                          if (latitude == null || latitude < -90 || latitude > 90) {
                            return 'Please enter a valid latitude (-90 to 90)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: longitude,
                        decoration: const InputDecoration(
                          hintText: "longitude",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        // keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*([.,]\d*)?$')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a longitude';
                          }
                          final double? longitude = double.tryParse(value.replaceAll(',', '.'));
                          if (longitude == null || longitude < -180 || longitude > 180) {
                            return 'Please enter a valid longitude (-180 to 180)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButtonWidget(
                        text: "Simpan",
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            lat = double.tryParse(latitude.text) ?? 0;
                            long = double.tryParse(longitude.text) ?? 0;
                            Get.back();
                            Get.snackbar(
                              "Berhasil",
                              "Valid LatLong",
                              animationDuration: const Duration(seconds: 2),
                              backgroundColor: Colors.white,
                            );
                            log("message lat : ${latitude.text} || long : ${longitude.text}");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        10.verticalSpaceFromWidth,

        ///
        ListTile(
          splashColor: Colors.blueAccent,
          leading: const Icon(Icons.compress_sharp),
          title: const Text("Set Distance"),
          onTap: () {
            Get.back();
            DialogService.showDrawerGeneral(
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Obx(
                        () => SliderTheme(
                          data: SliderTheme.of(Get.context!).copyWith(
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                          child: SizedBox(
                            width: 1.sw,
                            child: Slider(
                              activeColor: Colors.blue,
                              thumbColor: Colors.blue,
                              min: 1,
                              max: 10,
                              value: distanceBetween.value,
                              divisions: 9,
                              onChanged: onChangeSlider,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => Text("${distanceBetween.value * 100} meter")),
                      const SizedBox(height: 20),
                      CustomButtonWidget(
                        text: "Simpan",
                        onTap: () async {
                          DialogService.showLoading();
                          distanceValue.value = distanceBetween.value * 100;
                          await Future.delayed(const Duration(milliseconds: 500));
                          DialogService.closeLoading();
                          DialogService.closeDrawer();
                          Get.snackbar(
                            animationDuration: const Duration(seconds: 2),
                            "Berhasil",
                            "Distance diatur menjadi : ${distanceValue.value} meter",
                            backgroundColor: Colors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        10.verticalSpaceFromWidth,

        /// reset data
        20.verticalSpaceFromWidth,
        CustomButtonWidget(
          text: "Reset Data User Dummy",
          onTap: () async {
            DialogService.showLoading();
            HomeController.to.user.value.masuk = null;
            HomeController.to.user.value.keluar = null;
            HomeController.to.update();
            await Future.delayed(const Duration(milliseconds: 1000));
            DialogService.closeLoading();

            Get.back();
            Get.snackbar(
              "Berhasil",
              "Data user dumy telah direset",
              animationDuration: const Duration(seconds: 2),
              backgroundColor: Colors.white,
            );
          },
        ),
      ],
    ));
  }

  //* --------------------------------------------------------
  //* change arab text size settings.
  //* --------------------------------------------------------
  void onChangeSlider(double value) {
    distanceBetween.value = value;
    distanceValue.value = value * 100;
  }
}
