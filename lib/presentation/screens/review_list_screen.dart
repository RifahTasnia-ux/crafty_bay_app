import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/reviews_model.dart';
import '../state_holders/user_auth_controller.dart';
import '../widgets/review_item.dart';
import 'add_review_screen.dart';
import 'email_verification_screen.dart';

class ReviewListScreen extends StatefulWidget {
  final int productId;

  const ReviewListScreen({super.key, required this.productId});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewListController>().fetchReviews(widget.productId);
  }

  Future<void> _refreshReviews() async {
    await Get.find<ReviewListController>().fetchReviews(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: GetBuilder<ReviewListController>(
        builder: (reviewListController) {
          if (reviewListController.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (reviewListController.errorMessage.isNotEmpty) {
            return Center(child: Text(reviewListController.errorMessage));
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshReviews,
                  child: ListView.builder(
                    itemCount: reviewListController.reviews.length,
                    itemBuilder: (context, index) {
                      Data reviewData = reviewListController.reviews[index];
                      ReviewItemModel reviewItemModel = ReviewItemModel(
                        profileName: reviewData.profile?.cusName ?? 'Anonymous',
                        reviewDescription: reviewData.description ?? 'No description',
                      );
                      return ReviewItem(reviewItem: reviewItemModel);
                    },
                  ),
                ),
              ),
              _buildAddReviewWidget(reviewListController.reviews.length),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddReviewWidget(int totalReviews) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTotalReviewsWidget(totalReviews),
          FloatingActionButton(
            onPressed: () async {
              final isLoggedIn = await UserAuthController.checkLoggedInState();
              if (!isLoggedIn) {
                Get.to(() => const EmailVerificationScreen());
                showSnackMessage(context, "Please Log in first!");
                return;
              } else {
                Get.to(() => AddReviewScreen(productId: widget.productId));
              }
            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
            shape: const CircleBorder(),
            heroTag: null, // Ensure unique hero tag if used in multiple places
          ),
        ],
      ),
    );
  }

  Widget _buildTotalReviewsWidget(int totalReviews) {
    return Text(
      'Reviews ($totalReviews)',
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }
}
