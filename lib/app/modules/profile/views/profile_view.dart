import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF4F46E5);
  static const Color textGrey = Colors.grey;
  static const Color lightGreyBackground = Color(0xFFF5F5F5);
  static const Color profileIconBackground = Color(0xFFE0E0E0);
  static const Color profileIconColor = Colors.grey;
}

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.profileIconBackground,
                  backgroundImage:
                      controller.photoUrl.value != null
                          ? NetworkImage(controller.photoUrl.value!)
                          : null,
                  child:
                      controller.photoUrl.value == null
                          ? Icon(
                            Icons.person_outline,
                            size: 45,
                            color: AppColors.profileIconColor,
                          )
                          : null,
                ),
                SizedBox(height: 16),
                Text(
                  'Google Account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your profile information',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildInfoRow('Name', controller.name.value ?? 'N/A'),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildInfoRow(
                    'Email',
                    controller.email.value ?? 'N/A',
                  ),
                ),
                SizedBox(height: 16),
                _buildUserIdRow('User ID', controller.userId.value ?? 'N/A'),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  label: Text('Continue to Home'),
                  onPressed: controller.continueToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildUserIdRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
