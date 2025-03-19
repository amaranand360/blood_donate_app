import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
      bool _obscurePassword = true;

    void signInWithGoogle() async {
      // Implement Google Sign In here
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color.fromARGB(255, 255, 205, 216).withOpacity(0.3),
              const Color(0xFFFFCDD2).withOpacity(0.5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/pngegg.png',
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to Blood Donation App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your email address and password to login',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon:
                          Icon(Icons.person_outline, color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: TextEditingController(),
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // setState(() {
                          //   _obscurePassword = !_obscurePassword;
                          // });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // const TextField(
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('OR Login with'),
                  const SizedBox(height: 10),
                  Platform.isAndroid
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001)
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035),
                  SizedBox(
                    width: 289,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: SvgPicture.asset(
                              "assets/Google_svg.svg",
                              width:
                                  20, // Adjust the width according to your SVG size
                              height:
                                  20, // Adjust the height according to your SVG size
                            ),
                          ),
                          const SizedBox(width: 25),
                          // Add some space between the icon and the label
                          Text(
                            "Sign in with Google",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ReusableButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: GoogleFonts.nunitoSans(fontSize: 18),
      ),
      child: Text(text),
    );
  }
}
