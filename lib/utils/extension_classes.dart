import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app_string.dart';

extension AppLoader on EasyLoading {
  static showLoader() {
    EasyLoading.show(
      status: AppStrings.loading,
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }
}

extension SizedBoxDoubleUtils on double {
  Widget get sbh => SizedBox(height: this);

  Widget get sbw => SizedBox(width: this);
}

extension SizedBoxIntUtils on int {
  Widget get sbh => SizedBox(height: toDouble());

  Widget get sbw => SizedBox(width: toDouble());
}

extension SizedBoxStringUtils on String {
  Widget get sb {
    var list = split('x');
    return SizedBox(
        width: double.parse(list[0]), height: double.parse(list[1]));
  }
}

extension MediaQuerySize on BuildContext {
  double get getWidth => MediaQuery.of(this).size.width;

  double get getHeight => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  String capitalizeFirstLatter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String lowercaseFirstLatter() {
    return "${this[0].toLowerCase()}${substring(1).toLowerCase()}";
  }
}
