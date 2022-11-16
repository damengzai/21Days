import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constants.dart';

class AddToDoControl extends GetxController {
  //页面级数据
  //开始日期
  Rx<DateTime> startDate = DateTime.now().obs;

  // 结束日期
  Rx<DateTime> endDate = DateUtils.addDaysToDate(DateTime.now(), toDoDays) .obs;

  //是否反向打卡
  Rx<bool> revertClick = false.obs;
  //是否定时提醒
  Rx<bool> noticeAtTen = false.obs;

  setStartDate(DateTime startDateTmp) {
    startDate.value = startDateTmp;
  }

  setEndDate(DateTime endDateTmp) {
    endDate.value = endDateTmp;
  }
  setRevertClick(bool revertClickTmp) {
    revertClick.value = revertClickTmp;
  }
  setNoticeAtTen(bool notice) {
    noticeAtTen.value = notice;
  }
}
