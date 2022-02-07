import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/modules/product_detail/product_details_controller.dart';

class ProductDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailController(shoppingCartServices: Get.find()));
  }
}
