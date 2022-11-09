import 'package:days_21/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../localTheme.dart';
import '../control/toDoListControl.dart';
import '../utils/toDoUtils.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  ToDoListControl toDoListControl = Get.find();
  TextEditingController idController = TextEditingController();

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
                  ElevatedButton(
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
                  ElevatedButton(
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
          ),
          ExpansionTile(
            title: Text('testData'.tr),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: idController,
                        decoration: InputDecoration(labelText: 'id'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int id = int.parse(idController.value.text);
                        deleteTodo(id).then((value) {
                          if (value > 0) {
                            Get.showSnackbar(GetSnackBar(
                              messageText: Text(
                                'deleteSuc'.tr,
                                style: snakeBarTextStyle,
                              ),
                              duration: const Duration(seconds: 2),
                            ));
                            toDoListControl.removeToDo(id);
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              messageText: Text(
                                'deleteFail'.tr,
                                style: snakeBarTextStyle,
                              ),
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        });
                      },
                      child: Text('delete'.tr),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
