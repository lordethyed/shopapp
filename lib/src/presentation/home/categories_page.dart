import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:module5/src/data/products_model.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isLoading = true;

  final dio = Dio();

  List<String> categories = [];

  String? selectedCatory = '';

  List<Product> products = [];

  getCategories() async {
    final response = await dio.get("https://dummyjson.com/products/categories");
    final List<String> kCategories = [];
    for (var data in response.data) {
      kCategories.add(data.toString());
    }
    setState(() {
      categories = kCategories;

      isLoading = false;
    });
  }

  getItems(String value) async {
    try {
      final response =
          await dio.get("https://dummyjson.com/products/category/$value");
      final productsModel = ProductsModel.fromJson(response.data);
      setState(() {
        products = productsModel.productsList!;
        isLoading = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                DropdownMenu<String>(
                  initialSelection: selectedCatory,
                  onSelected: (String? value) {
                    getItems(value ?? "smartphones");
                    setState(() {
                      selectedCatory = value!;
                    });
                  },
                  dropdownMenuEntries:
                      categories.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Image.network(
                            products[index].images!.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          products[index].title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            products[index].description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "${products[index].price!.toString()}\$ ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
