import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/models/product_model.dart';
import 'package:vakinha_burger_mobile/app/models/shopping_model.dart';

class ShoppingCartServices extends GetxService {
  final _shoppingCard = <int, ShoppingModel>{}.obs;

  List<ShoppingModel> get products => _shoppingCard.values.toList();

  int get totalProducts => _shoppingCard.values.length;

  ShoppingModel? getById(int id) => _shoppingCard[id];

  void addAndRemoveProductInShoppingCard(ProductModel product,
      {required int qtd}) {
    if (qtd == 0) {
      _shoppingCard.remove(product.id);
    } else {
      _shoppingCard.update(product.id, (product) {
        product.quantity = qtd;
        return product;
      }, ifAbsent: () {
        return ShoppingModel(quantity: qtd, product: product);
      });
    }
  }

  double get totalValue {
    return _shoppingCard.values.fold(0, (totalValue, shoppingCardModel) {
      totalValue +=
          shoppingCardModel.product.price * shoppingCardModel.quantity;
      return totalValue;
    });
  }

  void clear() {
    _shoppingCard.clear();
  }
}
