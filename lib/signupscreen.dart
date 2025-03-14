import 'package:blood_donate_app/auth_controller.dart';
import 'package:blood_donate_app/loginscreen.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register as a Blood Donor',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authController.nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authController.phoneController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
               const SizedBox(height: 10),
            TextField(
                controller: authController.phoneController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: authController.bloodGroupController,
                decoration: const InputDecoration(labelText: 'Blood Group'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authController.phoneController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
                            const SizedBox(height: 10),
              TextField(
                controller: authController.phoneController,
                decoration: const InputDecoration(labelText: 'City'),
              ),

              const SizedBox(height: 10),
              TextField(
                controller: authController.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ReusableButton(
                text: 'Sign Up',
                onPressed: () {
                  authController.registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
