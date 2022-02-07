import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/icon_badge.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_burger_mobile/app/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => controller.tabIndex = value,
          currentIndex: controller.tabIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'Produtos'),
            BottomNavigationBarItem(
                icon: IconBadge(
                  icon: Icons.shopping_bag,
                  number: controller.totalProductQtd,
                ),
                label: 'Carrinho'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app), label: 'Sair')
          ],
        ),
      ),
      body: Navigator(
        initialRoute: '/menu',
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
        onGenerateRoute: controller.onGeneretadeRouter,
      ),
    );
  }
}
