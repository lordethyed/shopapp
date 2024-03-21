import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:module5/src/presentation/auth/sign_up_page.dart';
import 'package:module5/src/presentation/home/home_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();

  final dio = Dio();

  reset() async {
    try {
      final dataRegister = json.encode(
        {
          "username": email.text,
          "email": email.text,
          "firstName": name.text,
          "lastName": name.text,
          "age": 35,
          "password": password.text,
        },
      );
      final responseRegister =
          await dio.post("https://dummyjson.com/users/add", data: dataRegister);

      log(responseRegister.data.toString());
      final dataSignin = json.encode(
        {"username": email.text, "password": password.text},
      );
      final responseSignIn =
          await dio.post("https://dummyjson.com/auth/login", data: dataSignin);

      log(responseSignIn.data.toString());

      final token = responseSignIn.data['token'];
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(
          token: token,
        ),
      ));
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Row(),
          const Icon(
            Icons.password,
            size: 100,
          ),
          const Text(
            "Please enter your information.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: false,
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: false,
                      labelText: "Full name",
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: false,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.password)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordConfirmation,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: false,
                      labelText: "Password confirmation",
                      prefixIcon: const Icon(Icons.password)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: reset,
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 1,
                      width: 130,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 1,
                      width: 130,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey),
                        ),
                        child: const Text(
                          "Sing In",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SingUpPage(),
                          ),
                        ),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
