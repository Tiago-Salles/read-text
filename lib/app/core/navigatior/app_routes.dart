import 'package:flutter/material.dart';
import 'package:read_text/app/presenter/pages/favorite/favorite_page.dart';
import 'package:read_text/app/presenter/pages/home/home_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/home": (context) => const HomePage(),
    "/favorite": (context) => const FavoritePage()
  };
}
