import 'dart:convert';
import 'package:blood_donate_app/donor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'profile_page.dart';

class FindDonorsPage extends StatefulWidget {
  const FindDonorsPage({Key? key}) : super(key: key);

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _donors = [];
  List<Map<String, dynamic>> _filteredDonors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDonors();
  }

  Future<void> fetchDonors() async {
    try {
      final response = await http.get(Uri.parse(
          'https://blood-donation-backend-082i.onrender.com/api/home/default-donors'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        final donorsData = List<Map<String, dynamic>>.from(jsonData['donors']);
        setState(() {
          _donors = donorsData;
          _filteredDonors = donorsData;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load donors");
      }
    } catch (e) {
      print("Error fetching donors: $e");
      setState(() => _isLoading = false);
    }
  }

  // // Sample donor data
  // final List<Map<String, dynamic>> _donors = [
  //   {
  //     'name': 'Emily Davis',
  //     'location': 'Hertford British Hospital',
  //     'bloodType': 'B+',
  //     'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
  //   },
  //   {
  //     'name': 'Abdul Qader',
  //     'location': 'Apollo Hospital',
  //     'bloodType': 'A+',
  //     'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
  //   },
  //   {
  //     'name': 'Sara Ali',
  //     'location': 'St. Mary\'s Hospital',
  //     'bloodType': 'O+',
  //     'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
  //   },
  //   {
  //     'name': 'John Doe',
  //     'location': 'General Hospital',
  //     'bloodType': 'AB-',
  //     'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
  //   },
  //   {
  //     'name': 'Jane Smith',
  //     'location': 'City Clinic',
  //     'bloodType': 'B-',
  //     'image': 'https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369991.png',
  //   },
  // ];

  // List<Map<String, dynamic>> _filteredDonors = [];

  void _filterDonors(String query) {
    setState(() {
      _filteredDonors = _donors.where((donor) {
        final name = donor['name'].toLowerCase();
        final city = donor['city']?.toLowerCase() ?? '';
        final bloodGroup = donor['bloodGroup']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            city.contains(query.toLowerCase()) ||
            bloodGroup.contains(query.toLowerCase());
      }).toList();
    });
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Expanded(
              child: ListView.builder(
                itemCount: _filteredDonors.length,
                itemBuilder: (context, index) {
                  final donor = _filteredDonors[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            print("----------------donor------");
                            print(donor);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DonorDetailsPage(donor: donor),
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Donor Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  donor['profilePicture'] ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIf4R5qPKHPNMyAqV-FjS_OTBB8pfUV29Phg&s',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.person,
                                          size: 40, color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Donor Info - Flexible to avoid overflow
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person,
                                            color: Color(0xFFD32F2F), size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            donor['name'] ?? 'Username',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Color(0xFFD32F2F), size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            donor['address'] ?? 'Location',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Blood Type Section
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    donor['bloodGroup'] ?? 'Blood Type',
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
                    ),
                  );
                },
              ),
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
