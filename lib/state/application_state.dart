import 'package:flutter/material.dart';

class ApplicationState {
  ValueNotifier pageNotifier = ValueNotifier<int>(1);
  PageController controller = PageController(
    initialPage: 1,
  );
  int previousPageIndex;

  void goToPage(int pageIndex) {
    controller.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void goBack() {
    controller.animateToPage(previousPageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
