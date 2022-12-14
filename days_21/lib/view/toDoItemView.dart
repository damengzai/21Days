import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constants.dart';
import '../control/toDoListControl.dart';
import '../utils/toDoUtils.dart';
import '../bean/toDo.dart';
import '../bean/toDoStatus.dart';

const rightWidth = 80;

class ToDoItemView extends StatelessWidget {
  ToDoListControl toDoListControl = Get.find();
  final ToDo toDo;
  var checkDays = [];
  bool todayHasClicked = false;
  String todayClickNotice = 'unClick'.tr;
  IconData clickIcon = Icons.check_circle_outline;
  bool hasGiveUp = false;

  ToDoItemView({super.key, required this.toDo}) {
    DateTime today = DateTime.now();
    DateTime startDate =
        DateUtils.dateOnly(DateTime.tryParse(toDo.startDate) ?? DateTime.now());
    DateTime clickDate =
        DateUtils.dateOnly(DateTime.tryParse(toDo.clickDate) ?? DateTime.now());
    DateTime endDate =
        DateUtils.dateOnly(DateTime.tryParse(toDo.endDate) ?? DateTime.now());
    if (toDo.status == toDoStatus.giveUp.index) {
      hasGiveUp = true;
    } else {
      hasGiveUp = false;
    }

    int clickDiffDays = clickDate.difference(startDate).inDays + 1;
    int todoDiffDays = endDate.difference(startDate).inDays;
    todayHasClicked = today.difference(clickDate).inDays < 1;
    todayClickNotice = todayHasClicked ? 'hasClicked'.tr : 'unClick'.tr;
    todayClickNotice = hasGiveUp ? "hasGiveUp".tr : todayClickNotice;
    clickIcon = todayHasClicked
        ? Icons.mark_email_read_outlined
        : Icons.check_circle_outline;
    clickIcon = hasGiveUp ? Icons.gpp_bad_outlined : clickIcon;
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

  // ????????????
  clickToday() {
    toDo.clickDate = DateTime.now().toString();
    updateTodo(toDo).then((value) {
      if (value > 0) {
        toDoListControl.updateToDo(toDo);
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

  BoxDecoration giveUpForegroundDecoration() {
    if (hasGiveUp) {
      return BoxDecoration(color: Colors.black38);
    }
    return BoxDecoration();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IgnorePointer(
        ignoring: hasGiveUp,
        child: Container(
          foregroundDecoration: giveUpForegroundDecoration(),
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
                          Text('${renderStartEndDate(toDo.startDate)}??????'),
                          Text('${renderStartEndDate(toDo.endDate)}??????')
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
        ),
      ),
    );
  }
}
