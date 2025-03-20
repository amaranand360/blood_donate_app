import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateDonationRequestScreen extends StatelessWidget {
  const CreateDonationRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        title: Text(
          'Donation Request',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images.jpg',
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      _buildTextField(
                        icon: Icons.person,
                        label: 'Name',
                        iconColor: const Color(0xFFD32F2F),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        icon: Icons.location_on,
                        label: 'Location',
                        iconColor: const Color(0xFFD32F2F),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        icon: Icons.water_drop,
                        label: 'Blood Type',
                        iconColor: const Color(0xFFD32F2F),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        icon: Icons.phone,
                        label: 'Mobile',
                        iconColor: const Color(0xFFD32F2F),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        icon: Icons.note_alt_outlined,
                        label: 'Add Note',
                        iconColor: const Color(0xFFD32F2F),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle request submission
                  },
                  child: Text(
                    'Request',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        hintText: label,
        hintStyle: GoogleFonts.nunitoSans(
          color: Colors.grey.shade500,
        ),
        enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 2.0), // Red border when not focused
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0), // Thicker red border when focused
      ),
      ),
    );
  }
}
