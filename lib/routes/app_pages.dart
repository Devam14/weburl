import 'package:bubble_gpt/bindings/auth_binding.dart';
import 'package:bubble_gpt/bindings/dashboard_binding.dart';
import 'package:bubble_gpt/data/middleware/auth_middleware.dart';
import 'package:bubble_gpt/data/middleware/dashboard_middleware.dart';
import 'package:bubble_gpt/data/middleware/route_middleware.dart';
import 'package:bubble_gpt/ui/catagories/add_catagories_screen.dart';
import 'package:bubble_gpt/ui/dashboard/dashboard_screen.dart';
import 'package:bubble_gpt/ui/items/add_item_screen.dart';
import 'package:bubble_gpt/ui/login/login_screen.dart';
import 'package:bubble_gpt/ui/splash_screen.dart';
import 'package:get/get.dart';
import '../ui/items/items_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      middlewares: [DashboardMiddleware(), RouteGuard()],
    ),
    GetPage(
      name: Routes.login,
      binding: AuthBinding(),
      middlewares: [DashboardMiddleware(), RouteGuard()],
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.dashboard,
      binding: DashboardBinding(),
      page: () => const DashboardScreen(),
      middlewares: [AuthMiddleware(), RouteGuard()],
    ),
    GetPage(
      name: Routes.items,
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware(), RouteGuard()],
      page: () => ItemsScreen(categoryId: Get.arguments[0]),
    ),
    GetPage(
      name: Routes.addCatagories,
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware(), RouteGuard()],
      page: () => const AddCatagoriesScreen(),
    ),
    GetPage(
      name: Routes.addItems,
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware(), RouteGuard()],
      page: () => const AddItemScreen(),
    ),
  ];
}
