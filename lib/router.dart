import 'package:event_updates_tif/features/event_details/screens/event_details_screen.dart';
import 'package:event_updates_tif/features/home/screens/home_screen.dart';
import 'package:event_updates_tif/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchScreen(),
      );
    case EventDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EventDetailScreen(
          id: 0,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exists'),
          ),
        ),
      );
  }
}
