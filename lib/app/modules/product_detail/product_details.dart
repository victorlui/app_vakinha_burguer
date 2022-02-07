import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vakinha_burger_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/plus_minus_box.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';

import 'package:vakinha_burger_mobile/app/modules/product_detail/product_details_controller.dart';

class ProductDetails extends GetView<ProductDetailController> {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(),
      body: LayoutBuilder(
        builder: (context, constransts) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constransts.maxHeight,
                minWidth: constransts.maxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.width,
                    height: context.heightTransformer(reducedBy: 65),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'http://dartweek.academiadoflutter.com.br/images${controller.product.image}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      controller.product.name,
                      style: context.textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      controller.product.description,
                      style: context.textTheme.bodyText2!,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => PlusMinusBox(
                        qtd: controller.quantity,
                        minusCallback: controller.removeProduct,
                        plusCallback: controller.addProduct,
                        price: controller.product.price,
                      )),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Total',
                      style: VakinhaUi.textBold,
                    ),
                    trailing: Obx(
                      () => Text(
                        FormatterHelper.formatCurrency(controller.totalProce),
                        style: VakinhaUi.textBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: controller.addProductShoppingCard,
          child: Text(
            controller.alreadyAdded ? 'ATUALIZAR' : 'ADICIONAR',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
