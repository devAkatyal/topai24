import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class AppColors {
  static const Color primaryPurple = Color(
    0xFF4F46E5,
  ); // Adjust to match button
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
      body: Obx(
        // Use Obx to react to isLoading state
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Show loading spinner
          } else {
            // --- Main Content Column ---
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- Profile Icon ---
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColors.profileIconBackground,
                    // Optional: Display actual user photo if available
                    backgroundImage:
                        controller.photoUrl.value != null
                            ? NetworkImage(controller.photoUrl.value!)
                            : null,
                    // onBackgroundImageError: (_, __) {}, // Handle image load error
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

                  // --- Title & Subtitle ---
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

                  // --- Info Rows ---
                  // Use Obx around individual text fields that depend on controller data
                  Align(
                    alignment: Alignment.centerLeft, // Align THIS child left
                    child: _buildInfoRow(
                      'Name',
                      controller.name.value ?? 'N/A',
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft, // Align THIS child left
                    child: _buildInfoRow(
                      'Email',
                      controller.email.value ?? 'N/A',
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildUserIdRow('User ID', controller.userId.value ?? 'N/A'),
                  SizedBox(height: 40),

                  // --- Continue Button ---
                  ElevatedButton.icon(
                    label: Text('Continue to Home'),
                    onPressed: controller.continueToHome,
                    // Call controller method
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      // Button color
                      foregroundColor: Colors.white,
                      // Text color
                      minimumSize: Size(double.infinity, 50),
                      // Full width
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
                  // Padding at the bottom
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper widget for standard info rows
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

  // Helper widget specifically for the User ID row with background
  Widget _buildUserIdRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
        SizedBox(height: 4),
        Container(
          width: double.infinity, // Take full width
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground, // Light grey background
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15, // Slightly smaller for ID?
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
