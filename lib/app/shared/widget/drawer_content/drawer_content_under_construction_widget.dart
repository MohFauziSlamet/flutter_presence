import 'package:flutter/material.dart';
import 'package:flutter_presensi/app/shared/widget/button/custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DrawerContentUnderCostructionWidget extends StatelessWidget {
  final Function()? onTap;
  final String? title, desc;
  final String? lottie;
  const DrawerContentUnderCostructionWidget({
    super.key,
    this.onTap,
    this.title,
    this.desc,
    this.lottie,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showPicture(lottie ?? "assets/lottie/anim_service_empty.json"),
        SizedBox(
          height: 20.w,
        ),
        Text(
          title ?? "Layanan Segera Hadir",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.w,
        ),
        Text(
          desc ?? "Layanan yang kamu pilih akan segera hadir",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25.w,
        ),
        CustomButtonWidget(
          text: "Tutup",
          onTap: onTap ??
              () {
                Get.back();
              },
        ),
      ],
    );
  }
}

Widget showPicture(String path) {
  if (path.contains('.json')) {
    return Lottie.asset(
      path,
      height: 150.w,
      fit: BoxFit.fitHeight,
    );
  } else if (path.contains('.png') || path.contains('.jpg')) {
    return Image.asset(
      path,
      height: 150.w,
      fit: BoxFit.fitHeight,
    );
  } else if (path.contains('.svg')) {
    return SvgPicture.asset(
      path,
      height: 150.w,
      fit: BoxFit.fitHeight,
    );
  }

  return const Text(
    'Perhatikan Format Imagemu Teman!!!',
    textAlign: TextAlign.center,
  );
}
