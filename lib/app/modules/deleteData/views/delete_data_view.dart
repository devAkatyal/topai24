import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class DeleteDataView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete User',
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
            Image.asset('assets/images/ic_delete.jpg'),
            SizedBox(height: 24),
            ElevatedButton.icon(
              label: Text('Delete Data'),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text('Are you sure you want to delete user data?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Get.back(),
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          Get.back();
                          controller.deleteUserData();
                        },
                      ),
                    ],
                  ),
                  barrierDismissible: false,
                );
              },
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
