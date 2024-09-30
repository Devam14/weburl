// // lib/route_guard.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class RouteGuard extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     // Define your valid routes
//     const validRoutes = [
//       '/',
//       '/splash',
//       '/login',
//       '/dashboard',
//       '/items',
//       '/add_catagories',
//       '/add_items',
//     ];

//     // Check if the route is valid
//     if (!validRoutes.contains(route)) {
//       return const RouteSettings(name: '/login'); // Redirect to error page
//     }
//     return const RouteSettings(name: '/login'); // Redirect to error page
//   }
// }
