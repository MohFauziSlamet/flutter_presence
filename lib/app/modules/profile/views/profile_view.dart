// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    "assets/venturo-k2-194.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Moh Fauzi Slamet".toUpperCase(),
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            "mohfauzislamet@gmail.com",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          /// TOMBOL UPDATE PROFILE
          ListTile(
            onTap: () => controller.updateProfile(),
            leading: Icon(Icons.person),
            title: Text("Update Profile"),
          ),

          /// TOMBOL UPDATE PASSWORD
          ListTile(
            onTap: () => controller.updatePassword(),
            leading: Icon(Icons.vpn_key),
            title: Text("Update Password"),
          ),

          /// TOMBOL SETTING
          ListTile(
            onTap: () => controller.setting(),
            leading: Icon(Icons.settings),
            title: Text("Setting"),
          ),

          /// TOMBOL UNTUK LOGOUT
          ListTile(
            onTap: () => controller.logOut(),
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
            ),
          ),
        ],
      ),
    );
  }
}
