import 'package:flutter/cupertino.dart';
import 'package:hamroh_seller/models/create_order_item_model.dart';
import 'package:hamroh_seller/models/create_order_model.dart';
import 'package:hamroh_seller/models/product_model.dart';

class CreateOrderProvider extends ChangeNotifier {
  CreateOrderModel? order;

  setNumber(int number) {
    order = CreateOrderModel(number: number, paymentType: "new");
    notifyListeners();
  }

  itemExists(ProductModel product) {
    bool _exists = false;
    order!.items.forEach((item) {
      if (item.product == product) {
        _exists = true;
      }
    });
    return _exists;
  }

  addItem(CreateOrderItemModel item) {
    bool _exists = itemExists(item.product);
    if (!_exists) {
      order = order!.copyWith(items: [...order!.items, item]);
    }
    notifyListeners();
  }

  toggleItem(CreateOrderItemModel item) {
    bool _exists = itemExists(item.product);
    if (!_exists) {
      order = order!.copyWith(items: [...order!.items, item]);
    } else {
      order = order!.copyWith(items: [
        ...order!.items.where((elem) => elem.product != item.product).toList()
      ]);
    }
    notifyListeners();
  }

  removeItem(ProductModel product) {
    order = order!.copyWith(items: [
      ...order!.items.where((item) => item.product != product).toList()
    ]);
    notifyListeners();
  }
}
