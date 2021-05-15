import 'package:flutter/material.dart';
import 'package:training_application/state/application_state.dart';

class InheritedAplicationState extends InheritedWidget {
  final Widget child;
  final ApplicationState applicationState = ApplicationState();

  InheritedAplicationState({this.child}) : super(child: child);
  static ApplicationState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedAplicationState>()
        .applicationState;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
