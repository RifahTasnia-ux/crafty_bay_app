import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> addToCart(CartModel cartModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addToCart,
      body: cartModel.toJson(),
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {}
    _inProgress = false;
    update();
    return isSuccess;
  }
}