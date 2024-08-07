import 'package:flutter_presensi/app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:flutter_presensi/app/modules/dashboard/view/dashboard_view.dart';
import 'package:flutter_presensi/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileView(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.zoom,
    ),
  ];
}
