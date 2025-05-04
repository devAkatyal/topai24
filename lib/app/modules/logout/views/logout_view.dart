import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';

class LogoutView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logout User',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/images/ic_logout.jpg'),
            SizedBox(height: 24),

            ElevatedButton.icon(
              label: Text('Logout'),
              onPressed: controller.logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
