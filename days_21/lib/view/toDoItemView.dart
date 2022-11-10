import 'package:days_21/constant/constants.dart';
import 'package:days_21/utils/toDoUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bean/toDo.dart';
import '../bean/toDoStatus.dart';

const rightWidth = 80;

class ToDoItemView extends StatelessWidget {
  final ToDo toDo;
  var checkDays = [];
  bool todayHasClicked = false;
  String todayClickNotice = 'unClick'.tr;
  IconData clickIcon = Icons.check_circle_outline;

  ToDoItemView({super.key, required this.toDo}) {
    DateTime today = DateTime.now();
    DateTime startDate = DateUtils.dateOnly(DateTime.tryParse(toDo.startDate) ?? DateTime.now());
    DateTime clickDate = DateUtils.dateOnly(DateTime.tryParse(toDo.clickDate) ?? DateTime.now());
    DateTime endDate = DateUtils.dateOnly(DateTime.tryParse(toDo.endDate) ?? DateTime.now());

    int clickDiffDays = clickDate.difference(startDate).inDays + 1;
    int todoDiffDays = endDate.difference(startDate).inDays;
    todayHasClicked = today.difference(clickDate).inDays < 1;
    todayClickNotice = todayHasClicked ? 'hasClicked'.tr : 'unClick'.tr;
    clickIcon = todayHasClicked
        ? Icons.mark_email_read_outlined
        : Icons.check_circle_outline;
    int i = 0;
    while (i < todoDiffDays) {
      if (i < clickDiffDays) {
        checkDays.add(ToDoStatus.DONE);
      } else {
        checkDays.add(ToDoStatus.UNDONE);
      }
      ++i;
    }
  }

  Widget getC(ToDoStatus status, int index) {
    switch (status) {
      case ToDoStatus.DONE:
        return Icon(
          size: 12,
          key: Key('status_$index'),
          Icons.face_retouching_natural,
          color: Colors.green,
        );
      case ToDoStatus.UNDONE:
        return Icon(
          size: 12,
          key: Key('status_$index'),
          Icons.face_rounded,
          color: Colors.grey,
        );
      case ToDoStatus.FAILED:
        return Icon(
          size: 12,
          key: Key('status_$index'),
          Icons.face_retouching_off,
          color: Colors.red,
        );
      default:
        return Icon(
          size: 12,
          key: Key('status_$index'),
          Icons.face_rounded,
          color: Colors.grey,
        );
    }
  }

  renderStartEndDate(String date) {
    if (date.length > 10) {
      return date.substring(0, 10);
    }
    return '';
  }

  // 今日打卡
  clickToday() {
    toDo.clickDate = DateTime.now().toString();
    updateTodo(toDo).then((value) {
      if (value > 0) {
        Get.showSnackbar(
          GetSnackBar(
            messageText: Text(
              'clickSuc'.tr,
              style: snakeBarTextStyle,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            messageText: Text(
              'clickFail'.tr,
              style: snakeBarTextStyle,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  toDo.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: Get.width - rightWidth,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${renderStartEndDate(toDo.startDate)}开始'),
                      Text('${renderStartEndDate(toDo.endDate)}结束')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 26,
                width: Get.width - rightWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: checkDays.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getC(checkDays[index], index);
                  },
                ),
              ),
            ],
          ),
          InkWell(
            child: Column(
              children: [
                Icon(
                  clickIcon,
                  size: 29,
                ),
                Text(
                  todayClickNotice,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: () {
              if (todayHasClicked) {
                Get.showSnackbar(GetSnackBar(
                    messageText:
                        Text('hasClicked'.tr, style: snakeBarTextStyle),
                    duration: const Duration(seconds: 2)));
              } else {
                clickToday();
              }
            },
          ),
        ],
      ),
    ));
  }
}
