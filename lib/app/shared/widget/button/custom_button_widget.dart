import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final TextStyle? customTextStyle;
  final Color primaryColor;
  final Color? outlinedColor;
  final Color splashColor;
  final Color? shadowColor;
  final Color? disabledBackgroundColor;
  final Color textColor;
  final double? minimumWidth;
  final double? minimumHeight;
  final EdgeInsets? padding;
  final Widget? child;
  final double elevation;
  final double? borderRadius;
  final MaterialTapTargetSize tapTargetSize;
  final bool? isDisabled;
  final bool? isLoadingButton;
  final bool? useGradient;
  final Gradient? gradient;

  const CustomButtonWidget({
    super.key,
    this.onTap,
    this.elevation = 0,
    this.borderRadius,
    required this.text,
    this.customTextStyle,
    this.primaryColor = Colors.blue,
    this.splashColor = Colors.white,
    this.textColor = Colors.white,
    this.minimumWidth,
    this.minimumHeight,
    this.padding,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.isDisabled,
    this.isLoadingButton = false,
    this.outlinedColor,
  })  : child = null,
        useGradient = false,
        gradient = null;

  const CustomButtonWidget.outlined({
    super.key,
    this.onTap,
    this.elevation = 0,
    this.customTextStyle,
    this.borderRadius,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.textColor = Colors.blue,
    required this.text,
    this.minimumHeight,
    this.primaryColor = Colors.white,
    this.outlinedColor = Colors.blue,
    this.splashColor = Colors.blueAccent,
    this.minimumWidth,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.isLoadingButton = false,
  })  : child = null,
        useGradient = false,
        gradient = null;

  const CustomButtonWidget.textOnly({
    super.key,
    this.onTap,
    this.elevation = 0,
    this.customTextStyle,
    this.borderRadius,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.textColor = Colors.white,
    required this.text,
    this.minimumHeight,
    this.primaryColor = Colors.blue,
    this.outlinedColor = Colors.transparent,
    this.splashColor = Colors.blueAccent,
    this.minimumWidth,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.isLoadingButton = false,
  })  : child = null,
        useGradient = false,
        gradient = null;

  const CustomButtonWidget.child({
    super.key,
    this.onTap,
    this.elevation = 4,
    this.borderRadius,
    required this.child,
    this.minimumHeight,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.primaryColor = Colors.blue,
    this.splashColor = Colors.white,
    this.minimumWidth,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.isLoadingButton = false,
  })  : text = '',
        textColor = Colors.blue,
        customTextStyle = null,
        outlinedColor = null,
        useGradient = false,
        gradient = null;

  const CustomButtonWidget.outlinedChild({
    super.key,
    this.onTap,
    this.elevation = 4,
    this.borderRadius,
    required this.child,
    this.minimumHeight,
    this.primaryColor = Colors.white,
    this.outlinedColor = Colors.blue,
    this.splashColor = Colors.blueAccent,
    this.minimumWidth,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.isLoadingButton = false,
  })  : text = '',
        textColor = Colors.blue,
        customTextStyle = null,
        useGradient = false,
        gradient = null;

  const CustomButtonWidget.gradient({
    super.key,
    this.onTap,
    this.elevation = 0,
    this.customTextStyle,
    this.borderRadius,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.textColor = Colors.white,
    required this.text,
    this.minimumHeight,
    this.primaryColor = Colors.white,
    this.outlinedColor = Colors.transparent,
    this.splashColor = Colors.blue,
    this.minimumWidth,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.gradient,
    this.isLoadingButton = false,
  })  : useGradient = true,
        child = null;

  const CustomButtonWidget.gradientChild({
    super.key,
    this.onTap,
    this.elevation = 4,
    this.borderRadius,
    required this.child,
    this.minimumHeight,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.primaryColor = Colors.blue,
    this.splashColor = Colors.white,
    this.minimumWidth,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.isDisabled,
    this.isLoadingButton = false,
  })  : text = '',
        textColor = Colors.blue,
        customTextStyle = null,
        outlinedColor = null,
        useGradient = true,
        gradient = null;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isDisabled ?? false) ? null : onTap,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        shadowColor: shadowColor ?? Colors.black54,
        disabledBackgroundColor: disabledBackgroundColor ?? Colors.grey[400],
        backgroundColor: isDisabled == true ? Colors.grey[400] : primaryColor,
        foregroundColor: splashColor,
        tapTargetSize: tapTargetSize,
        minimumSize: Size(
          minimumWidth ?? double.infinity,
          minimumHeight ?? 0,
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 13.w,
              horizontal: 10.w,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 4.r,
          ),
          side: outlinedColor == null ? BorderSide.none : BorderSide(color: outlinedColor!),
        ),
      ),
      child: (isLoadingButton == true)
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.w,
              ),
            )
          : child ??
              Text(
                text.tr,
                textAlign: TextAlign.center,
                style: customTextStyle ??
                    TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
    );
  }
}
