import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignupPage extends StatefulWidget {
  final String userType;

  const SignupPage({Key? key, required this.userType}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  bool _obscurePassword = true;
  File? _medicalReport;
  final ImagePicker _picker = ImagePicker();

  // Blood group options
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  String? _selectedBloodGroup;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _medicalReport = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void signInWithGoogle() async {
      // Implement Google Sign In here
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        title:  Text('${widget.userType} Registration', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    // Column(
                    //   children: [
                    //     const Icon(
                    //       Icons.bloodtype,
                    //       color: Color(0xFFD32F2F),
                    //       size: 40,
                    //     ),
                    //     const SizedBox(height: 8),
                    //     Text(
                    //       '${widget.userType} Registration',
                    //       style: const TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Name field
                    TextFormField(
                      controller: _nameController,
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

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Age field
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        prefixIcon:
                            Icon(Icons.calendar_today, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        final age = int.tryParse(value);
                        if (age == null || age <= 0 || age > 120) {
                          return 'Please enter a valid age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Blood Group dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.bloodtype, color: Colors.grey),
                      ),
                      value: _selectedBloodGroup,
                      hint: const Text('Select Blood Group'),
                      items: _bloodGroups.map((String bloodGroup) {
                        return DropdownMenuItem<String>(
                          value: bloodGroup,
                          child: Text(bloodGroup),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBloodGroup = newValue;
                        });
                      },
                      validator: (value) {
                        if (widget.userType == 'Donor' ||
                            widget.userType == 'Patient') {
                          if (value == null || value.isEmpty) {
                            return 'Please select your blood group';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Phone field
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // City field
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'City',
                        prefixIcon:
                            Icon(Icons.location_city, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Address field (multiline)
                    // City field
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Full Address',
                        prefixIcon: Icon(Icons.home, color: Colors.grey),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
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
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
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
                    const SizedBox(height: 20),

                    // Medical report upload (only for Patient and Donor)
                    if (widget.userType == 'Patient' ||
                        widget.userType == 'Donor') ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Medical Report (Optional)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              if (_medicalReport != null) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _medicalReport!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _medicalReport != null
                                        ? 'Change Medical Report'
                                        : 'Upload Medical Report',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process signup
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Processing Sign Up...'),
                                backgroundColor: Colors.red,
                              ),

                            );
                          }
                          Navigator.pushReplacementNamed(context, '/home');

                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Or connect with
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or connect with',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 289,
                      height: 38,
                      child: ElevatedButton(
                        onPressed: signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFFD32F2F)),
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

                    const SizedBox(height: 20),

                    // Log in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Login',
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
      ),
    );
  }
}
