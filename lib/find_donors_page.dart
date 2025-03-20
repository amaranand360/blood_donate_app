import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';

class FindDonorsPage extends StatefulWidget {
  const FindDonorsPage({Key? key}) : super(key: key);

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Sample donor data
  final List<Map<String, dynamic>> _donors = [
    {
      'name': 'Emily Davis',
      'location': 'Hertford British Hospital',
      'bloodType': 'B+',
      'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
    },
    {
      'name': 'Abdul Qader',
      'location': 'Apollo Hospital',
      'bloodType': 'A+',
      'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
    },
    {
      'name': 'Sara Ali',
      'location': 'St. Mary\'s Hospital',
      'bloodType': 'O+',
      'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
    },
    {
      'name': 'John Doe',
      'location': 'General Hospital',
      'bloodType': 'AB-',
      'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
    },
    {
      'name': 'Jane Smith',
      'location': 'City Clinic',
      'bloodType': 'B-',
      'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
    },
  ];
  
  List<Map<String, dynamic>> _filteredDonors = [];
  
  @override
  void initState() {
    super.initState();
    _filteredDonors = List.from(_donors);
  }
  
  void _filterDonors(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredDonors = List.from(_donors);
      });
    } else {
      setState(() {
        _filteredDonors = _donors
            .where((donor) =>
                donor['name'].toLowerCase().contains(query.toLowerCase()) ||
                donor['location'].toLowerCase().contains(query.toLowerCase()) ||
                donor['bloodType'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        title: const Text(
          'Find Donors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
              Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFD32F2F)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: const Color(0xFFD32F2F).withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFD32F2F)),
                ),
              ),
              onChanged: _filterDonors,
            ),
          ),
          
          // Donor List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDonors.length,
              itemBuilder: (context, index) {
                final donor = _filteredDonors[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Donor Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              donor['image'],
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.person, size: 40, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Donor Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person, color: Color(0xFFD32F2F), size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      donor['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Color(0xFFD32F2F), size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      donor['location'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Blood Type
                          Column(
                            children: [
                              Text(
                                donor['bloodType'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Icon(
                                Icons.water_drop,
                                color: Color(0xFFD32F2F),
                                size: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}