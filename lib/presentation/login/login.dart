import 'package:flutter/material.dart';
import '../resources/routes_manager.dart';
import '../resources/color_manager.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Call login use case here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter email";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter password";
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: Text("Login", style: TextStyle(color: ColorManager.white),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registerRoute);
                },
                child: Text("Don't have an account? Sign up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.home);
                },
                child: Text("Home view button"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
