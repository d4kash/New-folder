import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/components/splash_screen/splash_screen.dart';




Future<void> main() async {
   FlutterView? flutterView = PlatformDispatcher.instance.views.firstOrNull;
  if (flutterView == null || flutterView.physicalSize.isEmpty) {
    PlatformDispatcher.instance.onMetricsChanged = () {
      flutterView = PlatformDispatcher.instance.views.firstOrNull;
      if (flutterView != null && !flutterView!.physicalSize.isEmpty) {
        PlatformDispatcher.instance.onMetricsChanged = null;
        WidgetsFlutterBinding.ensureInitialized();
        runApp(const MyApp());
      }
    };
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}