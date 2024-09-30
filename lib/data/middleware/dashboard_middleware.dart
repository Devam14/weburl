import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    var isLoggedIn = GetStorage().read(AppConstants.isLoggedIn);
    if (isLoggedIn != null) {
      return RouteSettings(name: "/dashboard");
    }
    return null;
  }
}
