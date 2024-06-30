import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/add_review_model.dart';
import '../state_holders/add_review_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class AddReviewScreen extends StatefulWidget {
  final int productId;

  const AddReviewScreen({super.key, required this.productId});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _idTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final TextEditingController _productIdTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _ratingTEController = TextEditingController();
  final TextEditingController _cusidTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddReviewController _addReviewController = Get.put(AddReviewController());

  @override
  void initState() {
    super.initState();
    _productIdTEController.text = widget.productId.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                GetBuilder<AddReviewController>(
                  builder: (controller) {
                    if (controller.inProgress) {
                      return const CenteredCircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Review createReviewModel = Review(
                            id: _idTEController.text,
                            description: _descriptionTEController.text,
                            rating:_ratingTEController.text,
                            customerId: _cusidTEController.text,
                            productId: _productIdTEController.text,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );
                          bool success = await _addReviewController.createReview(createReviewModel);
                          if (success) {
                            showSnackMessage('Review created successfully');
                          } else {
                            showSnackMessage('Adding Review failed! Try again.');
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
            controller: _firstNameTEController,
            decoration: const InputDecoration(hintText: 'First Name'),
            validator: (value) => value!.isEmpty ? 'Please enter your first name' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(hintText: 'Last Name'),
            validator: (value) => value!.isEmpty ? 'Please enter your last name' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionTEController,
            maxLines: 8,
            decoration: const InputDecoration(hintText: 'Write Review'),
            validator: (value) => value!.isEmpty ? 'Please enter your review' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            enabled: false,
            controller: _productIdTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Product ID'),
            validator: (value) => value!.isEmpty ? 'Product ID is required' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _ratingTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Your Rating (Out of 5)'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your rating';
              }
              final rating = double.tryParse(value);
              if (rating == null || rating < 0 || rating > 5) {
                return 'Please enter a valid rating between 0 and 5';
              }
              return null;
            },
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
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _descriptionTEController.dispose();
    _productIdTEController.dispose();
    _ratingTEController.dispose();
    _idTEController.dispose();
    _cusidTEController.dispose();
    super.dispose();
  }
}
