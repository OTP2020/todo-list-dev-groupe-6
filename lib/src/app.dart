import 'package:flutter/material.dart';

import '../helpers/drawer_navigation.dart';
import '../screens/categorie_screen.dart';
import '../screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerNavigation(),
    );
  }
}