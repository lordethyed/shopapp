import 'package:flutter/material.dart';
import 'package:module5/src/data/products_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product.title!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            child: Image.network(widget.product.thumbnail!),
          ),
          Text(widget.product.title!),
          Text(
            "Brand: ${widget.product.brand}",
            style: const TextStyle(color: Colors.red),
          ),
          Text(widget.product.description!),
        ],
      ),
    );
  }
}
