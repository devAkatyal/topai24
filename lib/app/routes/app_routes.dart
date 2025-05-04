part of 'app_pages.dart';

abstract class Routes {
  static const AUTH = _Paths.AUTH;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
  static const HOME = _Paths.HOME;
  static const LOGOUT = _Paths.LOGOUT;
  static const DELETE_DATA = _Paths.DELETE_DATA;
}

abstract class _Paths {
  static const AUTH = '/auth';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const HOME = '/home';
  static const LOGOUT = '/logout';
  static const DELETE_DATA = '/delete_data';
}
