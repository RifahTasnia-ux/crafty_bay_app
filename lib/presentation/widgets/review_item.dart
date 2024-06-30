import 'package:flutter/material.dart';

import '../../data/models/reviews_model.dart';

class ReviewItemModel {
  final String profileName;
  final String reviewDescription;

  ReviewItemModel({
    required this.profileName,
    required this.reviewDescription,
  });

  factory ReviewItemModel.fromData(Data data) {
    return ReviewItemModel(
      profileName: data.profile?.cusName ?? 'Anonymous',
      reviewDescription: data.description ?? '',
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.reviewItem});

  final ReviewItemModel reviewItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow(),
            const SizedBox(height: 8),
            _buildReviewDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.greenAccent,
          child: Icon(Icons.person_outlined, size: 15,),
          radius: 15,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            reviewItem.profileName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewDescription() {
    return Text(
      reviewItem.reviewDescription,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }
}
