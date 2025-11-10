import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;
    final name = user?.displayName ?? "";
    final email = user?.email ?? "";

    return Container(
      color: Color(0xFF121329),
      child: ListView(
        children: [
          SizedBox(height: 12),
          // Profile avatar + name
          Container(
            color: Color(0xFF20224A),
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.blue[400],
                  child: Text(
                    name.isNotEmpty
                        ? name[0].toUpperCase()
                        : (email.isNotEmpty ? email[0].toUpperCase() : "A"),
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ),
          // Notifications section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Push Notifications',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Receive notifications about swap offers',
                          style: TextStyle(color: Colors.white60, fontSize: 13),
                        ),
                      ],
                    ),
                    Switch(
                      value: pushNotifications,
                      activeColor: Color(0xFFFFD600),
                      onChanged: (val) {
                        setState(() {
                          pushNotifications = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Notifications',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Receive email updates',
                          style: TextStyle(color: Colors.white60, fontSize: 13),
                        ),
                      ],
                    ),
                    Switch(
                      value: emailNotifications,
                      activeColor: Color(0xFFFFD600),
                      onChanged: (val) {
                        setState(() {
                          emailNotifications = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.white10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.white70),
                  title: Text(
                    "About",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "BookSwap v1.0.0",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          // Sign out
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 4),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                foregroundColor: WidgetStatePropertyAll(Colors.redAccent),
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
                elevation: WidgetStatePropertyAll(0),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              icon: Icon(Icons.logout),
              label: Text('Sign Out'),
              onPressed: () => auth.logout(),
            ),
          ),
        ],
      ),
    );
  }
}
