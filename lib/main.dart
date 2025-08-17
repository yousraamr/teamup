import 'package:flutter/material.dart';
import 'package:teamup_app/routes/route_names.dart';
import 'routes/custom_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeamUp App',
      initialRoute: onBoardingScreen,
      onGenerateRoute: CustomRouter.allRoutes,
    );
  }
}