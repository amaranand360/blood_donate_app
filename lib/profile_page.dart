import 'package:flutter/material.dart';
import 'home_page.dart';
import 'find_donors_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isAvailableForDonation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        title:  Text(
          'Profile',
          style: GoogleFonts.nunitoSans(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
              Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to edit profile
            },
            child:  Text(
              'Edit',
              style: GoogleFonts.nunitoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Image
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: const NetworkImage(
                        'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png', // Replace with actual image URL
                      ),
                      onBackgroundImageError: (exception, stackTrace) {},
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Name
                   Text(
                    'Alice Capsey',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[600], size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'General Hospital, Rajkot',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.phone),
                          label: const Text('Call Now'),
                          onPressed: () {
                            // Make a call
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3b5998),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.send),
                          label: const Text('Request'),
                          onPressed: () {
                            // Send request
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Stats Cards
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  _buildStatCard('A+', 'Blood Type'),
                  _buildStatCard('06', 'Donated'),
                  _buildStatCard('03', 'Requested'),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // Available for donation toggle
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Color(0xFFD32F2F)),
              title: const Text('Available for donate'),
              trailing: Switch(
                value: _isAvailableForDonation,
                onChanged: (value) {
                  setState(() {
                    _isAvailableForDonation = value;
                  });
                },
                activeColor: const Color(0xFFD32F2F),
              ),
            ),
            
            const Divider(height: 1),
            
            // Menu Items
            _buildMenuItem(
              icon: Icons.share,
              title: 'Invite a friend',
              onTap: () {
                // Invite a friend
              },
            ),
            _buildMenuItem(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                // Edit profile
              },
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help',
              onTap: () {
                // Help
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color(0xFFD32F2F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find Donors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FindDonorsPage()),
            );
          }
          else if(index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                value,
                style:  GoogleFonts.nunitoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFD32F2F),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style:  GoogleFonts.nunitoSans(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}