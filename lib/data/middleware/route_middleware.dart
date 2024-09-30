import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Remove any extra slashes in the route
    String sanitizedRoute = route!.replaceAll(RegExp(r'/{2,}'), '/');

    // Check if the route is still valid after sanitization
    if (sanitizedRoute != route) {
      return RouteSettings(name: sanitizedRoute); // Redirect to sanitized route
    }

    return null; // Continue to the requested route
  }
}
