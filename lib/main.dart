import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vakinha_burger_mobile/app/core/bindings/applications_bindings.dart';
import 'package:vakinha_burger_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/app/routes/auth_routers.dart';
import 'package:vakinha_burger_mobile/app/routes/home_routers.dart';
import 'package:vakinha_burger_mobile/app/routes/orders_routers.dart';
import 'package:vakinha_burger_mobile/app/routes/product_routers.dart';

import 'package:vakinha_burger_mobile/app/routes/splash_routes.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const VaknhaBurguerMain());
}

class VaknhaBurguerMain extends StatelessWidget {
  const VaknhaBurguerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vakinha Burguer',
      theme: VakinhaUi.theme,
      debugShowCheckedModeBanner: false,
      initialBinding: ApplicationBinding(),
      getPages: [
        ...SplashRoutes.routers,
        ...AuthRouters.routers,
        ...HomeRouters.routers,
        ...ProductRouters.routers,
        ...OrdersRoutes.routers,
      ],
    );
  }
}
