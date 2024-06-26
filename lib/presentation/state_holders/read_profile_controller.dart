import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/read_profile_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  ReadProfileModel? _profileModel;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  ReadProfileModel? get profileModel => _profileModel;

  Future<bool> readProfile() async {
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.readProfile,
    );

    if (response.isSuccess) {
      try {
        _profileModel = ReadProfileModel.fromJson(response.responseData);
        _errorMessage = '';
        _inProgress = false;
        update();
        return true;
      } catch (e) {
        _errorMessage = 'Failed to parse profile data: $e';
      }
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return false;
  }
}
