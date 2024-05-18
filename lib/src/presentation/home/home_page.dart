import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:module5/src/data/products_model.dart';
import 'package:module5/src/presentation/home/add_item.dart';
import 'package:module5/src/presentation/home/categories_page.dart';
import 'package:module5/src/presentation/home/notification_page.dart';
import 'package:module5/src/presentation/home/product_details_page.dart';
import 'package:module5/src/presentation/home/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.token});
  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Product> products = [];

  final dio = Dio();

  fetchProducts() async {
    final response = await dio.get("https://dummyjson.com/products");
    final productsModel = ProductsModel.fromJson(response.data);
    setState(() {
      products = productsModel.productsList!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddItem(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(token: widget.token),
            ),
          ),
          icon: const Icon(Icons.search),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NoticationPage())),
            icon: const Icon(Icons.notifications),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoriesPage())),
            child: const Text("Categories"),
          ),
        ],
        title: const Text(
          "Korea - GoYang",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                    child: Image.asset(
                      'assets/images/Imagen 18.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "Lastest Items",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(10.0),
                        width: 100,
                        height: 150,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                      product: products[index]))),
                          child: Column(
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
                      ),
                    ),
                  ),
                  const Text(
                    "Your publications",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 400,
                    child: GridView.count(
                      childAspectRatio: 1 / 0.8,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      children: products
                          .map(
                            (e) => InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsPage(product: e),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                width: 100,
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 50,
                                      child: Image.network(
                                        e.images!.first,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      e.title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.description!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "${e.price!.toString()}\$ ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
