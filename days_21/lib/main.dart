import 'package:days_21/control/ToDoListControl.dart';
import 'package:days_21/i18n/MyTranslation.dart';
import 'package:days_21/page/newToDo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/toDoItemView.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    defaultTransition: Transition.native,
    translations: MyTransLation(),
    locale: Locale('zh', 'CN'),
    // en, UK
    getPages: [
      GetPage(name: '/home', page: () => MyApp()),
      GetPage(name: '/newToDo', page: () => const NewToDo())
    ],
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final toDoListControl = Get.put(ToDoListControl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title".tr),
      ),
      body: Center(
        child: Obx(() => ListView.builder(
            itemCount: toDoListControl.toDoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ToDoItemView(
                key: Key('i' + index.toString()),
                toDo: toDoListControl.toDoList[index],
              ); // Text(toDoListControl.toDoList[index].name);
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/newToDo"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
