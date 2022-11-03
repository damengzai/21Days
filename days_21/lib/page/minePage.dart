import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../localTheme.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ExpansionTile(
            title: Text('changeTheme'.tr),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      Get.changeTheme(lightTheme);
                    },
                    child: null,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(lightTheme.primaryColor),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      Get.changeTheme(darkTheme);
                    },
                    child: null,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(darkTheme.primaryColor),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
