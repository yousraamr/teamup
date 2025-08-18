import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teamup_app/routes/route_names.dart';
import 'routes/custom_router.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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