import 'package:crafty_bay/data/models/create_profile_model.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../state_holders/complete_profie_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import 'main_bottom_nav_bar_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _idTEController = TextEditingController();
  final TextEditingController _userIdTEController = TextEditingController();
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _stateTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _postcodeTEController = TextEditingController();
  final TextEditingController _countryTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _faxTEController = TextEditingController();
  final TextEditingController _shippingNameTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController = TextEditingController();
  final TextEditingController _shippingPostcodeTEController = TextEditingController();
  final TextEditingController _shippingCityTEController = TextEditingController();
  final TextEditingController _shippingStateTEController = TextEditingController();
  final TextEditingController _shippingCountryTEController = TextEditingController();
  final TextEditingController _shippingPhoneTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CompleteProfileController _completeProfileController = Get.put(CompleteProfileController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const AppLogo(),
                const SizedBox(height: 16),
                Text('Complete Profile', style: textTheme.headline6),
                const SizedBox(height: 4),
                Text('Get started with us by providing your details', style: textTheme.subtitle1),
                const SizedBox(height: 24),
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                GetBuilder<CompleteProfileController>(
                  builder: (controller) {
                    if (controller.inProgress) {
                      return const CenteredCircularProgressIndicator();
                    }

                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          CreateProfile createProfileModel = CreateProfile(
                            id: _idTEController.text,
                            userId: _userIdTEController.text,
                            cusName: _fullNameTEController.text,
                            cusAdd: _addressTEController.text,
                            cusCity: _cityTEController.text,
                            cusState: _stateTEController.text,
                            cusPostcode: _postcodeTEController.text,
                            cusCountry: _countryTEController.text,
                            cusPhone: _mobileTEController.text,
                            cusFax: _faxTEController.text,
                            shipName: _shippingNameTEController.text,
                            shipAdd: _shippingAddressTEController.text,
                            shipCity: _shippingCityTEController.text,
                            shipState: _shippingStateTEController.text,
                            shipPostcode: _shippingPostcodeTEController.text,
                            shipCountry: _shippingCountryTEController.text,
                            shipPhone: _shippingPhoneTEController.text,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );

                          bool success = await _completeProfileController.completeProfile(createProfileModel);

                          if (success) {
                            Get.off(() => const MainBottomNavBarScreen());
                          } else {
                            showSnackMessage(_completeProfileController.errorMessage, isError: true);
                          }
                        }
                      },
                      child: const Text('Complete'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _fullNameTEController,
            decoration: const InputDecoration(hintText: 'Full name'),
            validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _addressTEController,
            decoration: const InputDecoration(hintText: 'Full Address'),
            validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(hintText: 'City'),
            validator: (value) => value!.isEmpty ? 'Please enter your city' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _stateTEController,
            decoration: const InputDecoration(hintText: 'State'),
            validator: (value) => value!.isEmpty ? 'Please enter your state' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _postcodeTEController,
            decoration: const InputDecoration(hintText: 'Post Code'),
            validator: (value) => value!.isEmpty ? 'Please enter your postcode' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _countryTEController,
            decoration: const InputDecoration(hintText: 'Country'),
            validator: (value) => value!.isEmpty ? 'Please enter your country' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            decoration: const InputDecoration(hintText: 'Mobile'),
            validator: (value) => value!.isEmpty ? 'Please enter your mobile number' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _faxTEController,
            decoration: const InputDecoration(hintText: 'Fax Number'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingNameTEController,
            decoration: const InputDecoration(hintText: 'Shipping name'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingAddressTEController,
            decoration: const InputDecoration(hintText: 'Shipping address'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingCityTEController,
            decoration: const InputDecoration(hintText: 'Shipping city'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingStateTEController,
            decoration: const InputDecoration(hintText: 'Shipping state'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingPostcodeTEController,
            decoration: const InputDecoration(hintText: 'Shipping postcode'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingCountryTEController,
            decoration: const InputDecoration(hintText: 'Shipping country'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingPhoneTEController,
            decoration: const InputDecoration(hintText: 'Shipping phone number'),
          ),
        ],
      ),
    );
  }

  void showSnackMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _idTEController.dispose();
    _userIdTEController.dispose();
    _fullNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _stateTEController.dispose();
    _postcodeTEController.dispose();
    _addressTEController.dispose();
    _countryTEController.dispose();
    _faxTEController.dispose();
    _shippingNameTEController.dispose();
    _shippingAddressTEController.dispose();
    _shippingPostcodeTEController.dispose();
    _shippingCityTEController.dispose();
    _shippingStateTEController.dispose();
    _shippingCountryTEController.dispose();
    _shippingPhoneTEController.dispose();
    super.dispose();
  }
}
