import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/services/auth_services.dart';
import 'package:vakinha_burger_mobile/app/core/services/shopping_cart_services.dart';
import 'package:vakinha_burger_mobile/app/models/order.dart';
import 'package:vakinha_burger_mobile/app/models/shopping_model.dart';
import 'package:vakinha_burger_mobile/app/modules/home/home_controller.dart';
import 'package:vakinha_burger_mobile/app/repositories/order/order_repository.dart';

class ShoppingCardController extends GetxController {
  final AuthServices _authServices;
  final ShoppingCartServices _shoppingCardServices;
  final OrderRepository _orderRepository;

  final _address = ''.obs;
  final _cpf = ''.obs;

  ShoppingCardController(
      {required AuthServices authServices,
      required ShoppingCartServices shoppingCartServices,
      required OrderRepository orderRepository})
      : _authServices = authServices,
        _shoppingCardServices = shoppingCartServices,
        _orderRepository = orderRepository;

  List<ShoppingModel> get products => _shoppingCardServices.products;
  double get totalValue => _shoppingCardServices.totalValue;
  set address(String address) => _address.value = address;
  set cpf(String cpf) => _cpf.value = cpf;

  void addQuantityProduct(ShoppingModel shoppingModel) {
    _shoppingCardServices.addAndRemoveProductInShoppingCard(
        shoppingModel.product,
        qtd: shoppingModel.quantity + 1);
  }

  void subtractQuantityProduct(ShoppingModel shoppingModel) {
    _shoppingCardServices.addAndRemoveProductInShoppingCard(
        shoppingModel.product,
        qtd: shoppingModel.quantity - 1);
  }

  void clear() => _shoppingCardServices.clear();

  Future<void> creatOrder() async {
    final userId = _authServices.getUserId();
    final order = Order(
      userId: userId!,
      cpf: _cpf.value,
      address: _address.value,
      items: products,
    );

    var orderPix = await _orderRepository.createOrder(order);

    orderPix.copyWith(totalvalue: totalValue);
    clear();
    Get.offNamed('/orders/finished', arguments: orderPix);
    Get.back(id: HomeController.NAVIGATOR_KEY);
  }
}
