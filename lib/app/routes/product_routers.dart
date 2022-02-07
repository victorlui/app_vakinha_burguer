import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/modules/product_detail/product_details.dart';
import 'package:vakinha_burger_mobile/app/modules/product_detail/product_details_bindings.dart';

class ProductRouters {
  ProductRouters._();

  static final routers = <GetPage>[
    GetPage(
        name: '/product_details',
        binding: ProductDetailsBindings(),
        page: () => const ProductDetails()),
  ];
}
