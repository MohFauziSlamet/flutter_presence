import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  runApp(ScreenUtilInit(
    minTextAdapt: true,
    useInheritedMediaQuery: true,
    designSize: const Size(428, 926),
    builder: (context, child) => child!,
    child: GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.dashboard,
      getPages: AppPages.routes,
    ),
  ));
}
