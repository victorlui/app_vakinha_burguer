import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/plus_minus_box.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_button.dart';
import 'package:vakinha_burger_mobile/app/modules/order/shopping_card/shopping_card_controller.dart';
import 'package:validatorless/validatorless.dart';

class ShoppingCardPage extends GetView<ShoppingCardController> {
  final formKey = GlobalKey<FormState>();
  ShoppingCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: formKey,
                child: Visibility(
                  visible: controller.products.isNotEmpty,
                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nenhum item adicionado no carrinho',
                        style: context.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Carrinho',
                              style: context.textTheme.headline6?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.primaryColorDark),
                            ),
                            IconButton(
                              onPressed: controller.clear,
                              icon: const Icon(
                                Icons.delete_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Column(
                            children: controller.products
                                .map((p) => PlusMinusBox(
                                      qtd: p.quantity,
                                      price: p.product.price,
                                      minusCallback: () {
                                        controller.subtractQuantityProduct(p);
                                      },
                                      plusCallback: () {
                                        controller.addQuantityProduct(p);
                                      },
                                      elevated: true,
                                      label: p.product.name,
                                      calculateTotal: true,
                                      backgroundColor: Colors.white,
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total do pedido',
                                style: context.textTheme.bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                FormatterHelper.formatCurrency(
                                    controller.totalValue),
                                style: context.textTheme.bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 30,
                          thickness: 1,
                        ),
                        const _AddressField(),
                        const SizedBox(
                          height: 20,
                        ),
                        const _CPFField(),
                        const Spacer(),
                        Center(
                          child: SizedBox(
                            width: context.widthTransformer(reducedBy: 10),
                            child: VakinhaButton(
                              label: 'Finalizar',
                              onPressed: () {
                                final formValid =
                                    formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  controller.creatOrder();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AddressField extends GetView<ShoppingCardController> {
  const _AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 34,
          child: Text(
            'Endereço de entrega',
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.address = value;
          },
          validator: Validatorless.required('Endereço obrigatório'),
          decoration: const InputDecoration(
            hintText: 'Digite o endereço',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}

class _CPFField extends GetView<ShoppingCardController> {
  const _CPFField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 34,
          child: Text(
            'CPF',
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.cpf = value;
          },
          validator: Validatorless.multiple([
            Validatorless.required('CPF obrigatório'),
            Validatorless.cpf('CPF inválido'),
          ]),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Digite o CPF',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
