import 'package:flutter/material.dart';
import 'package:flutter_project1/auth/auth_service.dart';
import 'package:flutter_project1/pages/feature_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
    Navigator.pop(context);
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple.shade50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("image/sw.jpg"),
                ),
                SizedBox(height: 15),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.person,
                  title: "My Profile",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.medical_services,
                  title: "First Aid Guide",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FirstAidPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: "Settings & Privacy",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: "Help",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}