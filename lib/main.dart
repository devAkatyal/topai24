import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/modules/login/controllers/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LoginController(), permanent: true);
  runApp(const MyApp());
}

const MaterialColor primarySwatch = MaterialColor(
  0xFF4F46E5,
  <int, Color>{
    50: Color(0xFFEDECFC),
    100: Color(0xFFD2D1F8),
    200: Color(0xFFB4B3F3),
    300: Color(0xFF9695EE),
    400: Color(0xFF7F7EEC),
    500: Color(0xFF4F46E5), // Base
    600: Color(0xFF3A31C8),
    700: Color(0xFF2F27B1),
    800: Color(0xFF251E9A),
    900: Color(0xFF1A147D),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Topai24 App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}