import 'package:get/get.dart';
import 'package:topai24/app/modules/deleteData/views/delete_data_view.dart';
import 'package:topai24/app/modules/logout/views/logout_view.dart';
import 'package:topai24/app/modules/profile/views/profile_view.dart';
import '../modules/auth/auth_wrapper.dart';
import '../modules/deleteData/bindings/delete_data_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/logout/bindings/logout_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthWrapper(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGOUT,
      page: () => LogoutView(),
      binding: LogoutBinding(),
    ),
    GetPage(
      name: _Paths.DELETE_DATA,
      page: () => DeleteDataView(),
      binding: DeleteDataBinding(),
    ),
  ];
}