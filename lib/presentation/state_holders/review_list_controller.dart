import 'package:crafty_bay/data/models/reviews_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<Data> _reviews = [];

  bool get inProgress => _inProgress;

  List<Data> get reviews => _reviews;

  String get errorMessage => _errorMessage;

  Future<bool> fetchReviews(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.ReviewList(productId),
    );

    if (response.isSuccess) {
      _errorMessage = '';
      ReviewsModel reviewsModel = ReviewsModel.fromJson(response.responseData);
      _reviews = reviewsModel.data ?? [];
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to fetch reviews';
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
