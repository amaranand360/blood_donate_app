import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool _obscurePassword = true;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Allows content to adjust when the keyboard appears
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
          child: SingleChildScrollView( // ✅ Prevents overflow issues
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // Dismiss keyboard on scroll
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50), // Adjust spacing for better layout
                  Image.asset(
                    'assets/pngegg.png',
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to Blood Donation App',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your email address and password to login',
                    style: GoogleFonts.nunitoSans(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Toggle password visibility
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Signup',
                          style: GoogleFonts.nunitoSans(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Extra space at the bottom for scrolling
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



    // const Text('OR Login with'),
                  // const SizedBox(height: 10),
                  // Platform.isAndroid
                  //     ? SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.001)
                  //     : SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.035),
                  // SizedBox(
                  //   width: 289,
                  //   height: 38,
                  //   child: ElevatedButton(
                  //     onPressed: signInWithGoogle,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         side: const BorderSide(color: Colors.black),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 0),
                  //           child: SvgPicture.asset(
                  //             "assets/Google_svg.svg",
                  //             width:
                  //                 20, // Adjust the width according to your SVG size
                  //             height:
                  //                 20, // Adjust the height according to your SVG size
                  //           ),
                  //         ),
                  //         const SizedBox(width: 25),
                  //         // Add some space between the icon and the label
                  //         Text(
                  //           "Sign in with Google",
                  //           style: GoogleFonts.nunitoSans(
                  //             color: Colors.black,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),