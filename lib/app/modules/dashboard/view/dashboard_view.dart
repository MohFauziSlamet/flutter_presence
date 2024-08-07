import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_presensi/app/modules/home/views/home_view.dart';
import 'package:flutter_presensi/app/modules/profile/views/profile_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = DashboardController.to;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,

      body: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          SizedBox.shrink(),
          ProfileView(),
        ],
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Finger'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: controller.curIndexTab.value, //optional, default as 0
        onTap: (int i) => controller.changePage(index: i),
      ),
    );
  }
}
