import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps/dependencies.dart';
import 'package:google_maps/routing/router.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Agenda Rubi",
      routerConfig: router,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
