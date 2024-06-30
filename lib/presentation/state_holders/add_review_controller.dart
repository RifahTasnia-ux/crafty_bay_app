import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

import '../../data/models/add_review_model.dart';

class AddReviewController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> createReview(Review reviewModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createReview,
      body: reviewModel.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {}

    _inProgress = false;
    update();
    return isSuccess;
  }
}
