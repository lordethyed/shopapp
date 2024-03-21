import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final dio = Dio();
  String? selectedCatory = '';
  String? selectedCurrecy = '';
  List<String> categories = [];
  List<String> currencies = ['USD', 'EURO', "KZT", "JPY"];

  getCategories() async {
    final response = await dio.get("https://dummyjson.com/products/categories");
    final List<String> kCategories = [];
    for (var data in response.data) {
      kCategories.add(data.toString());
    }
    setState(() {
      categories = kCategories;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const Row(),
          const Text(
            "Create a new product",
            style: TextStyle(color: Colors.red),
          ),
          const Text("Item information"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: false,
              labelText: "Item Name",
            ),
          ),
          DropdownMenu<String>(
            initialSelection: selectedCatory,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedCatory = value!;
              });
            },
            dropdownMenuEntries:
                categories.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          DropdownMenu<String>(
            initialSelection: selectedCurrecy,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedCatory = value!;
              });
            },
            dropdownMenuEntries:
                currencies.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: false,
              labelText: "Price",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: false,
              labelText: "Description",
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
