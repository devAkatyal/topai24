import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class DeleteDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
