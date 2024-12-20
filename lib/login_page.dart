import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/custom_widget/custom_text_field.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Login",
            key: Key('AppBarTitle'), // Unique key for the AppBar title
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: const LoginBody(),
    );
  }
}

// Login Body
class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<bool> _loginUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text != savedEmail ||
        passwordController.text != savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    Object loginData = {
      'email': savedEmail,
      'password': savedPassword,
    };
    log(loginData.toString());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Welcome Medical Professionals",
            key: Key('WelcomeText'), // Unique key for the welcome text
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: emailController,
            label: "Email",
            obscureText: false,
            key: const Key('EmailField'), // Unique key for the email field
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: passwordController,
            label: "Password",
            obscureText: true,
            key:
                const Key('PasswordField'), // Unique key for the password field
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            key: const Key('LoginButton'), // Unique key for the login button
            onPressed: () async {
              bool result = await _loginUser();
              result ? Get.offAllNamed('/dashboard') : null;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  key: const Key(
                      'SignupButton'), // Unique key for the signup button
                  onPressed: () {
                    Get.offAllNamed("/signup");
                  },
                  child: const Text("Signup"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
