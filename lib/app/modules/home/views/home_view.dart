import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AppColors {
  // Define your app's colors
  static const Color primaryPurple = Color(0xFF4F46E5); // Example purple
  static const Color textGrey = Colors.grey;
  static const Color lightGreyBorder = Color(0xFFE0E0E0);
  static const Color inputBackground = Colors.white; // Or very light grey
  static const Color labelColor = Color(0xFF555555); // Darker grey for labels
}

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or a light background color
      appBar: AppBar(
        title: Text(
          'Personal Info',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: controller.continueToLogout,
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: controller.continueToDeleteData,
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          // Wrap content in a Form widget
          key: controller.formKey, // Assign the key from the controller
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Address Field ---
              _buildSectionLabel('Address'),
              TextFormField(
                controller: controller.addressController,
                decoration: _inputDecoration('Enter your address'),
                validator: controller.validateAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),

              // --- Phone Number Field ---
              _buildSectionLabel('Phone Number'),
              TextFormField(
                controller: controller.phoneController,
                decoration: _inputDecoration('Enter 10-digit phone number'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // Only allow digits
                maxLength: 10,
                // Enforce length
                validator: controller.validatePhone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),

              // --- Age Dropdown ---
              _buildSectionLabel('Age'),
              Obx(
                // Wrap Dropdown with Obx to react to selection changes
                () => DropdownButtonFormField<int>(
                  value: controller.selectedAge.value,
                  // Bind value to controller observable
                  items:
                      controller.ageOptions.map((int age) {
                        return DropdownMenuItem<int>(
                          value: age,
                          child: Text(age.toString()),
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    controller.selectedAge.value =
                        newValue; // Update controller observable
                  },
                  decoration: _inputDecoration('').copyWith(
                    // Remove hint text from default decoration
                    hintText: 'Select age', // Use hint property here
                  ),
                  validator: controller.validateAge,
                  // Use controller's validator
                  hint: Text('Select age'),
                  // Show hint when no value is selected
                  isExpanded: true, // Make dropdown take available width
                ),
              ),
              SizedBox(height: 20),

              // --- Additional Information Field ---
              _buildSectionLabel('Additional Information'),
              TextFormField(
                controller: controller.additionalInfoController,
                decoration: _inputDecoration(
                  'Enter any additional information',
                ),
                maxLines: 4, // Multi-line input
                textInputAction: TextInputAction.done,
                // No validator needed unless it's required
              ),
              SizedBox(height: 30),

              Obx(
                () => ElevatedButton.icon(
                  icon:
                      controller.isLoading.value
                          ? SizedBox(
                            // Show spinner when loading
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Icon(Icons.save_alt, size: 20), // Your save icon
                  label: Text('Save Information'),
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller
                              .saveInformation, // Disable button when loading
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for section labels
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.labelColor,
        ),
      ),
    );
  }

  // Helper for input decoration
  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.textGrey.withOpacity(0.8)),
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightGreyBorder, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightGreyBorder, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.primaryPurple,
          width: 1.5,
        ), // Highlight border on focus
      ),
      // Remove default counter for phone number length
      counterText: "",
    );
  }
}
