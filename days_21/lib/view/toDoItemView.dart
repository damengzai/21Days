import 'package:days_21/bean/toDoStatus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bean/toDo.dart';

const rightWidth = 50;

class ToDoItemView extends StatelessWidget {
  final ToDo toDo;
  var checkDays = [];

  ToDoItemView({required Key key, required this.toDo}) : super(key: key) {
    checkDays = [
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.DONE,
      ToDoStatus.FAILED,
      ToDoStatus.UNDONE,
      ToDoStatus.UNKNOWN,
      ToDoStatus.UNKNOWN,
      ToDoStatus.UNKNOWN,
      ToDoStatus.UNKNOWN,
      ToDoStatus.UNKNOWN
    ];
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
          Icons.format_align_center,
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
                height: 16,
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
            child: const Icon(Icons.check),
            onTap: () {
              print('object' + toDo.id.toString());
            },
          ),
        ],
      ),
    ));
  }
}
