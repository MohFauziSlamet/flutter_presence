import 'package:flutter_presensi/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_presensi/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_presensi/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
   