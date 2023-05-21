import 'package:flutter/material.dart';
import 'package:projet/services/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Home',
      theme: ThemeData.dark(),
      routeInformationParser: RouterService.getRoutes().routeInformationParser,
      routeInformationProvider:
          RouterService.getRoutes().routeInformationProvider,
      routerDelegate: RouterService.getRoutes().routerDelegate,
      // debugShowCheckedModeBanner: false,
    );
  }
}
