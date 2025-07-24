import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterfp25/editprofile.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  late String email;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    name = widget.userName;
    email = widget.email;
  }

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentName: name,
          currentEmail: email,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        name = result['name'] ?? name;
        email = result['email'] ?? email;

        final imagePath = result['image'];
        if (imagePath != null && imagePath is String && imagePath.isNotEmpty) {
          profileImage = File(imagePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Colors.black;
    final Color cardColor = Colors.white;
    final Color backgroundColor = Colors.grey[100]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: cardColor,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Image
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 55,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : const AssetImage('images/default_profile.png') as ImageProvider,
              ),
            ),

            const SizedBox(height: 25),

            // Profile Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Edit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _navigateToEditProfile,
                icon: const Icon(Icons.edit, size: 20),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: accentColor,
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
