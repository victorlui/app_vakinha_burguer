import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/services/auth_services.dart';
import 'package:vakinha_burger_mobile/app/core/services/shopping_cart_services.dart';
import 'package:vakinha_burger_mobile/app/modules/menu/menu_bindings.dart';
import 'package:vakinha_burger_mobile/app/modules/menu/menu_page.dart';
import 'package:vakinha_burger_mobile/app/modules/order/shopping_card/shopping_card_bindings.dart';
import 'package:vakinha_burger_mobile/app/modules/order/shopping_card/shopping_card_page.dart';

class HomeController extends GetxController {
  static const NAVIGATOR_KEY = 1;
  final ShoppingCartServices _shoppingCardServices;

  final _tabIndex = 0.obs;
  final _tabs = ['/menu', '/order/shopping_card', '/exit'];

  int get tabIndex => _tabIndex.value;
  int get totalProductQtd => _shoppingCardServices.totalProducts;

  HomeController({
    required ShoppingCartServices shoppingCartServices,
  }) : _shoppingCardServices = shoppingCartServices;

  set tabIndex(int index) {
    _tabIndex(index);
    if (_tabs[index] == '/exit') {
      Get.find<AuthServices>().logout();
    } else {
      Get.toNamed(_tabs[index], id: NAVIGATOR_KEY);
    }
  }

  Route? onGeneretadeRouter(RouteSettings settings) {
    if (settings.name == '/menu') {
      return GetPageRoute(
          settings: settings,
          page: () => const MenuPage(),
          binding: MenuBindings(),
          transition: Transition.fadeIn);
    }

    if (settings.name == '/order/shopping_card') {
      return GetPageRoute(
          settings: settings,
          page: () => ShoppingCardPage(),
          binding: ShoppingCardBinding(),
          transition: Transition.fadeIn);
    }
    return null;
  }
}