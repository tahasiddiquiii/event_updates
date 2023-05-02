import 'package:event_updates_tif/constants/global_variables.dart';
import 'package:event_updates_tif/features/home/screens/home_screen.dart';
import 'package:event_updates_tif/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVENTS',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          // color: GlobalVariables.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const HomeScreen(),
    );
  }
}
