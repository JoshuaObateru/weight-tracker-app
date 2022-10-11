import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/presentation/pages/auth_page.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/presentation/pages/weight_tracker_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/weight_tracker':
        return MaterialPageRoute(builder: (_) => const WeightTrackerPage());
      default:
        return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }
}
