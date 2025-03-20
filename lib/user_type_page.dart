import 'package:blood_donate_app/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({Key? key}) : super(key: key);

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFD32F2F).withOpacity(0.1),
              Colors.white,
              Colors.white,
              const Color(0xFFFFCDD2).withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/pngegg.png',
                        height: 200,
                        // If you don't have this asset, replace with a network image or placeholder
                        errorBuilder: (context, error, stackTrace) => Image.network(
                          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-03-16%20at%202.13.54%E2%80%AFPM-pwxgntu0nnByMtzadyYmTplJ7UfJsM.png',
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 40),
                       Text(
                        'I am a',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildUserTypeOption('Donor'),
                      const SizedBox(height: 15),
                      _buildUserTypeOption('Patient'),
                      const SizedBox(height: 15),
                      _buildUserTypeOption('Hospital'),
                      const SizedBox(height: 15),
                      _buildUserTypeOption('Organization'),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedUserType != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(userType: selectedUserType!),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child:  Text('Confirm', style: GoogleFonts.nunitoSans(fontSize: 16,color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeOption(String userType) {
    final isSelected = selectedUserType == userType;
    
    return InkWell(
      onTap: () {
        setState(() {
          selectedUserType = userType;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFFD32F2F) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userType,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFD32F2F) : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.circle,
                        size: 16,
                        color: Color(0xFFD32F2F),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}