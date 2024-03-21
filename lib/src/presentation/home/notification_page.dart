import 'package:flutter/material.dart';

class NoticationPage extends StatefulWidget {
  const NoticationPage({super.key});

  @override
  State<NoticationPage> createState() => _NoticationPageState();
}

class _NoticationPageState extends State<NoticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Notications",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Row(),
          const Text(
            "Messages",
            style: TextStyle(color: Colors.red),
          ),
          const Text(
            "Please enter your information",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 500,
            child: ListView.builder(
              itemBuilder: (context, index) => const ListTile(
                leading: Column(
                  children: [
                    Icon(Icons.person),
                    Icon(Icons.mail),
                  ],
                  
                ),
                title: Text('@eburras1q'),
                subtitle: Text("This is some awesome thinking!"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
