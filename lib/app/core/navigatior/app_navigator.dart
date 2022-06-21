import 'package:flutter/material.dart';

enum NavigationType {
  pushToNamed,
  pushNamedAndRemoveUntil,
}

class AppNavigation {
  static navigateToNamed(
      BuildContext context, String routeName, NavigationType navigationType) {
    if (navigationType == NavigationType.pushToNamed) {
      Navigator.of(context).pushNamed(routeName);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }
}
