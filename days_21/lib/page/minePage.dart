import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../localTheme.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
            },
            child: Text(
              'data',
            ),
          ),
        ],
      ),
    );
  }
}
