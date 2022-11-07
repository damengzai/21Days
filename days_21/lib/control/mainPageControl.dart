import 'package:get/get.dart';
class MainPageControl extends GetxController {
  // Rx<Widget> currentPage = CurrentToDoPage().obs;
  Rx<int> currentPageIndex = 0.obs;

  changePage(int page) {
    switch (page) {
      case 0:
        currentPageIndex.value = 0;
        // currentPage.value = CurrentToDoPage();
        break;
      case 1:
        currentPageIndex.value = 1;
        // currentPage.value = AllToDoPage();
        break;
      case 2:
        currentPageIndex.value = 2;
        // currentPage.value = MinePage();
        break;
      default:
        currentPageIndex.value = 0;
        // currentPage.value = CurrentToDoPage();
        break;
    }
  }
}
