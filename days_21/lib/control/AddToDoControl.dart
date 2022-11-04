import 'package:get/get.dart';

class AddToDoControl extends GetxController {
  //页面级数据
  //开始日期
  Rx<DateTime> startDate = DateTime.now().obs;

  // 结束日期
  Rx<DateTime> endDate = DateTime.now().obs;

  setStartDate(DateTime startDateTmp) {
    startDate.value = startDateTmp;
  }

  setEndDate(DateTime endDateTmp) {
    endDate.value = endDateTmp;
  }
}
