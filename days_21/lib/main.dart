import 'package:days_21/i18n/myTranslation.dart';
import 'package:days_21/page/newToDo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:days_21/page/currentToDoPage.dart';
import 'page/allToDoPage.dart';
import 'page/minePage.dart';
import 'localTheme.dart';
import 'control/mainPageControl.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    defaultTransition: Transition.native,
    translations: MyTranslation(),
    locale: Locale('zh', 'CN'),
    // en, UK
    // 主题
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.light,
    getPages: [
      GetPage(name: '/home', page: () => MyApp()),
      GetPage(name: '/newToDo', page: () => NewToDo())
    ],
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final mainPageControl = Get.put(MainPageControl());
  final pageList = [CurrentToDoPage(), AllToDoPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title".tr),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: mainPageControl.currentPageIndex.value,
            items: [
              BottomNavigationBarItem(
                  label: 'doing'.tr, icon: const Icon(Icons.access_time)),
              BottomNavigationBarItem(
                  label: 'all'.tr,
                  icon: const Icon(Icons.align_horizontal_left)),
              BottomNavigationBarItem(
                  label: 'mine'.tr, icon: const Icon(Icons.person_outlined)),
            ],
            onTap: (int index) {
              mainPageControl.changePage(index);
            },
          )),
      body: Obx(() => pageList[mainPageControl.currentPageIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/newToDo"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
