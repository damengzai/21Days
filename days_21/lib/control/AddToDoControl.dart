import 'package:get/get.dart';

class AddToDoControl extends GetxController{
  Rx<DateTime> startDate = DateTime.now().obs;
  setStartDate(DateTime startDateTmp) {
    startDate.value = startDateTmp;
  }
}