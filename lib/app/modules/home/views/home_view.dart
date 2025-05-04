import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF4F46E5);
  static const Color textGrey = Colors.grey;
  static const Color lightGreyBorder = Color(0xFFE0E0E0);
  static const Color inputBackground = Colors.white;
  static const Color labelColor = Color(0xFF555555);
}

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel('Address'),
              TextFormField(
                controller: controller.addressController,
                decoration: _inputDecoration('Enter your address'),
                validator: controller.validateAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              _buildSectionLabel('Phone Number'),
              TextFormField(
                controller: controller.phoneController,
                decoration: _inputDecoration('Enter 10-digit phone number'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validator: controller.validatePhone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              _buildSectionLabel('Age'),
              Obx(
                () => DropdownButtonFormField<int>(
                  value: controller.selectedAge.value,
                  items:
                      controller.ageOptions.map((int age) {
                        return DropdownMenuItem<int>(
                          value: age,
                          child: Text(age.toString()),
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    controller.selectedAge.value = newValue;
                  },
                  decoration: _inputDecoration(
                    '',
                  ).copyWith(hintText: 'Select age'),
                  validator: controller.validateAge,

                  hint: Text('Select age'),

                  isExpanded: true,
                ),
              ),
              SizedBox(height: 20),
              _buildSectionLabel('Additional Information'),
              TextFormField(
                controller: controller.additionalInfoController,
                decoration: _inputDecoration(
                  'Enter any additional information',
                ),
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 30),
              Obx(
                () => ElevatedButton.icon(
                  icon:
                      controller.isLoading.value
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Icon(Icons.save_alt, size: 20),
                  label: Text('Save Information'),
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.saveInformation,
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
        borderSide: BorderSide(color: AppColors.primaryPurple, width: 1.5),
      ),
      counterText: "",
    );
  }
}
