import 'package:bybirr_flutter/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              
              title: Text('User name'),
              subtitle: Text('test@gmail.com'),
              trailing: Icon(Icons.verified),
            ),
            5.height,
            Container(
              height: 0.4,
              color: gray,
            ),
            10.height,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Personal',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                5.width,
                Expanded(
                  child: Container(
                    height: 0.4,
                    color: gray,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: gray.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                  color: colorScheme.surface),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                     
                    },
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.person_2_outlined),
                    ),
                    title: Text(
                      'Personal info',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    onTap: () {
                     // NotificationScreen().launch(context);
                    },
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.notifications_outlined),
                    ),
                    title: const Text(
                      'Notifications',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                 
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.dark_mode),
                    ),
                    title: const Text(
                      'Dark mode',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Switch(
                        value: themeProvider.getIsDarkMode,
                        onChanged: (value) {
                          themeProvider.setDarkMode = value;
                        }),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    onTap: () {
                     // SecurityScreen().launch(context);
                    },
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.security),
                    ),
                    title: const Text(
                      'Security',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            3.height,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                5.width,
                Expanded(
                  child: Container(
                    height: 0.4,
                    color: gray,
                  ),
                ),
              ],
            ),
            3.height,
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: gray.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                  color: colorScheme.surface),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.help_outline),
                    ),
                    title: const Text(
                      'Help center',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.info_outline),
                    ),
                    title: const Text(
                      'About us',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.email_outlined),
                    ),
                    title: const Text(
                      'Contact us',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.privacy_tip_outlined),
                    ),
                    title: const Text(
                      'Privacy policy',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.follow_the_signs_outlined),
                    ),
                    title: const Text(
                      'Fellow us on social media',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      child: Icon(Icons.rate_review_outlined),
                    ),
                    title: const Text(
                      'Rate us',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: gray,
                  ),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
