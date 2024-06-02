import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../state_holders/product_list_by_category_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductList(widget.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: GetBuilder<ProductListByCategoryController>(
          builder: (productListByCategoryController) {
            if (productListByCategoryController.inProgress) {
              return const CenteredCircularProgressIndicator();
            }

            return GridView.builder(
              itemCount: productListByCategoryController.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: ProductCard(
                      product: productListByCategoryController.productList[index],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
