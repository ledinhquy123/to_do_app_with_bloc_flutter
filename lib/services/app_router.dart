import 'package:flutter/material.dart';
import 'package:to_do_app/screens/recycle_bin.dart';
import 'package:to_do_app/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      // case PedingTasksScreen.id:
      //   return MaterialPageRoute(builder: (_) => const PedingTasksScreen());
      // case CompletedTasksScreen.id:
      //   return MaterialPageRoute(builder: (_) => const CompletedTasksScreen());
      // case FavouriteTasksScreen.id:
      //   return MaterialPageRoute(builder: (_) => const FavouriteTasksScreen());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      default:
        return null;
    }
  }
}