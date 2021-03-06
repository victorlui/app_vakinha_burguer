import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/modules/order/shopping_card/shopping_card_controller.dart';
import 'package:vakinha_burger_mobile/app/repositories/order/order_repository.dart';
import 'package:vakinha_burger_mobile/app/repositories/order/order_repository_implements.dart';

class ShoppingCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(
      () => OrderRepositoryImpl(restClient: Get.find()),
    );
    Get.put(ShoppingCardController(
        shoppingCartServices: Get.find(),
        authServices: Get.find(),
        orderRepository: Get.find()));
  }
}
