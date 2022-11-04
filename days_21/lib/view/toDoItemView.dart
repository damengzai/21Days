import 'package:days_21/bean/toDoStatus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bean/toDo.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Get.theme.dividerColor),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  toDo.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 16,
                width: Get.width - 50,
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
              print('object'+toDo.id.toString());
            },
          ),
        ],
      ),
    );
  }
}
