import 'package:flutter/material.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';

class Themes{
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    timePickerTheme: const TimePickerThemeData(
      dayPeriodColor: AppColors.primaryBg,
      backgroundColor: Colors.white,
      dialBackgroundColor: AppColors.primaryBg,
      dialHandColor: AppColors.primary,
      hourMinuteColor: AppColors.primaryBg,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary)
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary)
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.primary
        )
      ),
      confirmButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary)
      ),
      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primary)
      ),
      backgroundColor: AppColors.primaryBg,
      todayForegroundColor: const WidgetStatePropertyAll(AppColors.primary),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return null;
      }),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.0)
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? AppColors.primary : null;
      })
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBg
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      hintStyle: const TextStyle(
        color: Colors.grey
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.primary
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Colors.black12
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Colors.red
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Colors.red
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Colors.black12
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.black12;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.black38;
          }
          return Colors.white;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          )
        )
      )
    )
  );
}