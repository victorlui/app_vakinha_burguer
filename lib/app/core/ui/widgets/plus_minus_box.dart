import 'package:flutter/material.dart';
import 'package:vakinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vakinha_burger_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_rounded.dart';

class PlusMinusBox extends StatelessWidget {
  final bool elevated;
  final Color? backgroundColor;
  final String? label;
  final int qtd;
  final double price;
  final VoidCallback minusCallback;
  final VoidCallback plusCallback;
  final bool calculateTotal;

  const PlusMinusBox(
      {Key? key,
      this.elevated = false,
      this.backgroundColor,
      this.label,
      required this.qtd,
      required this.price,
      required this.minusCallback,
      required this.plusCallback,
      this.calculateTotal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevated ? 5 : 0,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black26,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: label != null,
              child: Text(
                label ?? '',
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                VakinhaButtonRounded(
                  onPress: minusCallback,
                  label: '-',
                ),
                Text('$qtd'),
                VakinhaButtonRounded(
                  onPress: plusCallback,
                  label: '+',
                ),
              ],
            ),
            Visibility(visible: label == null, child: const Spacer()),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              constraints: const BoxConstraints(minWidth: 70),
              child: Text(
                FormatterHelper.formatCurrency(
                    calculateTotal ? price * qtd : price),
                style: VakinhaUi.textBold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
