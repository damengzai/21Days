import 'package:days_21/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bean/toDo.dart';
import '../control/toDoListControl.dart';
import '../utils/toDoUtils.dart';

import '../control/addToDoControl.dart';

class NewToDo extends StatelessWidget {
  NewToDo({super.key});

  final addToDoControl = Get.put(AddToDoControl());
  ToDoListControl toDoListControl = Get.find();

  TextEditingController nameController = TextEditingController();

  addTodo() async {
    if (nameController.text.isEmpty) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text('nameNotEmpty'.tr, style: snakeBarTextStyle),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    ToDo todo = ToDo(
        name: nameController.text,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        startDate: addToDoControl.startDate.value.toString(),
        endDate: addToDoControl.endDate.value.toString(),
        clickDate: addToDoControl.startDate.value.toString(),
        status: toDoStatus.doing.index,
        type: addToDoControl.revertClick.value
            ? toDoType.revert.index
            : toDoType.normal.index);

    toDoListControl.addDoingToDo(todo);
    insertTodo(todo).then((value) {
      if (value > 0) {
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            'addSuc'.tr,
            style: snakeBarTextStyle,
          ),
          duration: const Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            'addFail'.tr,
            style: snakeBarTextStyle,
          ),
          duration: const Duration(seconds: 2),
        ));
      }
    });
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
    return GestureDetector(
      onTap: () {
        // FocusScopeNode focusScopeNode = Get.focusScope as FocusScopeNode;
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus &&
            focusScopeNode.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('newTodo'.tr),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                // 名字
                GetBuilder(
                  init: AddToDoControl(),
                  builder: (_) {
                    return TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'todoName'.tr,
                          labelStyle: const TextStyle(fontSize: 14)),
                    );
                  },
                  dispose: (_) {
                    nameController.dispose();
                  },
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
                // 反向打卡按钮
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: addToDoControl.revertClick.value,
                        onChanged: (bool? checked) {
                          addToDoControl.setRevertClick(checked ?? false);
                        })),
                    Text(
                      'revertClick'.tr,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                Text(
                  'whatsRevertClick'.tr,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
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
