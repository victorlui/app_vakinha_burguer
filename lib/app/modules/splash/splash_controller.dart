import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/services/auth_services.dart';

class SplashController extends GetxController {
  void checkLogged() {
    Get.putAsync(() => AuthServices().init());
  }
}
