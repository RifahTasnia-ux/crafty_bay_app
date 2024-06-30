class Review {
  String id;
  String description;
  String rating;
  String customerId;
  String productId;
  DateTime createdAt;
  DateTime updatedAt;

  Review({
    required this.id,
    required this.description,
    required this.rating,
    required this.customerId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'rating': rating,
      'customer_id': customerId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
