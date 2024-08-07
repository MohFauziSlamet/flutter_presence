import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi/app/shared/widget/dialog_content/dialog_content_loading_widget.dart';
import 'package:flutter_presensi/app/shared/widget/drawer_content/drawer_content_under_construction_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogService {
  static bool closeLoading() {
    Get.closeAllSnackbars();
    if (Get.isDialogOpen! || Get.isBottomSheetOpen!) Get.back();

    return false;
  }

  static bool closeDrawer() {
    Get.closeAllSnackbars();
    if (Get.isBottomSheetOpen!) Get.back();

    return false;
  }

  static closeDialog() {
    Get.closeAllSnackbars();
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static bool showLoading({
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      DialogContentLoadingWidget(
        barrierDismissible: kDebugMode ? true : barrierDismissible,
      ),
      barrierDismissible: kDebugMode ? true : barrierDismissible,
    );

    return true;
  }

  static void showBasicToast({
    Duration duration = const Duration(milliseconds: 1500),
    required String message,
    Color messageColor = Colors.white,
    Color backgroundColor = Colors.black,
    int maxLines = 2,
    bool withButton = false,
    String? buttonText,
    VoidCallback? onPressedButton,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.w,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: messageColor,
                    ),
                    maxLines: maxLines,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  withButton
                      ? InkWell(
                          onTap: onPressedButton ?? () {},
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              buttonText ?? "Lihat Semua",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
        borderWidth: 0,
        backgroundColor: Colors.transparent,
        duration: duration,
        snackStyle: SnackStyle.GROUNDED,
      ),
    );
  }

  static Future<T?> showDrawerGeneral<T>({
    bool withStrip = true,
    double? radius,
    double marginTop = 0,
    required Widget content,
    bool isDismissable = true,
    EdgeInsets? padding,
    double? paddingBottom,
    RouteSettings? settings,
    bool isScrollControlled = true,
    bool enableDrag = true,
  }) async {
    return await Get.bottomSheet<T>(
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? 8.r),
          topRight: Radius.circular(radius ?? 8.r),
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius ?? 8.r),
                topRight: Radius.circular(radius ?? 8.r),
              ),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w,
                ),
            child: Column(
              children: [
                Visibility(
                  visible: withStrip,
                  child: Container(
                    width: 65.w,
                    height: 6.w,
                    margin: EdgeInsets.only(bottom: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2.5),
                      ),
                      color: withStrip ? const Color(0xffe8e8e8) : Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Get.mediaQuery.padding.bottom + (paddingBottom ?? 0.0),
                  ),
                  child: content,
                ),
              ],
            ),
          ),
        ),
      ).marginOnly(top: marginTop),
      isDismissible: isDismissable,
      backgroundColor: Colors.transparent,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      settings: settings,
    );
  }

  static Future<T?> showDrawerUnderConstruction<T>({
    Function()? onTap,
    String? title,
    String? desc,
    String? lottie,
  }) async {
    return showDrawerGeneral<T>(
      content: DrawerContentUnderCostructionWidget(
        onTap: onTap,
        title: title,
        desc: desc,
        lottie: lottie,
      ),
    );
  }

  static Future<T?> showDialogGeneral<T>({
    double margin = 40,
    double radius = 14,
    Color? color,
    Widget? content,
    bool barrierDismissible = true,
    bool isUseTimer = false,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool isShowCloseButton = false,
    String? dialogName,
  }) async {
    Completer<T?> completer = Completer<T?>();

    Get.dialog<T>(
      WillPopScope(
        onWillPop: () => Future.value(barrierDismissible),
        child: Center(
          child: SingleChildScrollView(
            physics: physics,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.all(margin),
                padding: isShowCloseButton ? EdgeInsets.zero : (padding ??= EdgeInsets.all(16.w)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: content ?? const SizedBox(),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      name: dialogName,
    );

    //* Timer untuk menutup dialog setelah 5 detik
    if (barrierDismissible && isUseTimer) {
      Future.delayed(const Duration(seconds: 5), () {
        if (Get.isDialogOpen!) {
          Get.back();
          if (!completer.isCompleted) {
            completer.complete();
          }
        }
      });
    }

    return completer.future;
  }
}
