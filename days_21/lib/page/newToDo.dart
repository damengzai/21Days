import 'package:days_21/bean/toDo.dart';
import 'package:days_21/control/toDoListControl.dart';
import 'package:days_21/utils/toDoUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../control/addToDoControl.dart';
import '../constant/constants.dart';

class NewToDo extends StatelessWidget {
  NewToDo({super.key});

  final addToDoControl = Get.put(AddToDoControl());
  ToDoListControl toDoListControl = Get.find();

  TextEditingController nameController = TextEditingController();

  addTodo() async {
    ToDo todo = ToDo(
        name: nameController.text,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        startDate: addToDoControl.startDate.value.toString(),
        endDate: addToDoControl.endDate.value.toString(),
        clickDate: addToDoControl.startDate.value.toString(),
        status: 2,
        type: 1);

    toDoListControl.addToDo(todo);
    await insertTodo(todo);
  }

  renderDateItem(
    BuildContext context,
    String title,
    Rx<DateTime> dateTime,
    Function selectCallback,
  ) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime(
            dateTime.value.year,
            dateTime.value.month,
            dateTime.value.day,
          ),
          firstDate: DateTime(2022),
          lastDate: DateTime(2023),
        ).then((value) {
          selectCallback(value);
          // addToDoControl.setStartDate(value ?? DateTime.now());
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title.tr),
            Obx(
              () => Text(
                dateTime.string.substring(0, 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('newTodo'.tr),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // FocusScopeNode focusScopeNode = Get.focusScope as FocusScopeNode;
            print('----------GestureDetector');
            // FocusScopeNode focusScopeNode = FocusScope.of(context);
            // if (!focusScopeNode.hasPrimaryFocus &&
            //     focusScopeNode.focusedChild != null) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // }
          },
          child: Center(
            child: Column(
              children: [
                // 名字
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'todoName'.tr),
                ),
                // 开始日期
                renderDateItem(
                  context,
                  'startDate',
                  addToDoControl.startDate,
                  (value) {
                    // 设置开始日期
                    addToDoControl.setStartDate(value);
                    // 设置结束日期， 默认+21天
                    addToDoControl
                        .setEndDate(DateUtils.addDaysToDate(value, 21));
                  },
                ),
                // 结束日期
                renderDateItem(
                    context,
                    'endDate',
                    addToDoControl.endDate,
                    (value) => {
                          {addToDoControl.setEndDate(value ?? DateTime.now())},
                        }),
                // 添加按钮
                TextButton(
                  onPressed: () {
                    addTodo();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: Text(
                    'add'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
