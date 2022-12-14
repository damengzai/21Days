import 'package:days_21/page/singleToDo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'i18n/myTranslation.dart';
import 'localTheme.dart';
import 'page/newToDo.dart';
import 'page/currentToDoPage.dart';
import 'page/allToDoPage.dart';
import 'page/minePage.dart';
import 'control/mainPageControl.dart';

void main() {
  // debugPaintSizeEnabled=true; // 所有盒子范围
  // debugPaintBaselinesEnabled = true; // 基线
  // debugPaintLayerBordersEnabled = true; //所有layer展示橙色边框
  // debugPaintPointersEnabled = true; // 可点击区域范围
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
    // home: MyApp(),
    getPages: [
      GetPage(name: '/home', page: () => MyApp()),
      GetPage(name: '/newToDo', page: () => NewToDo()),
      GetPage(name: '/singleToDo', page: () => SingleToDo())
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
        onPressed: () {
          Get.toNamed("/newToDo");
          // Get.to(() => NewToDo(), transition: Transition.rightToLeft);
          // mainPageControl.showNotification();
          // mainPageControl.scheduleDailyTenAMNotification();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
