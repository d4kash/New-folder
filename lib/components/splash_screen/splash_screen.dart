import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_authentication/pilot_login.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGINPERSIST = 'isLogedIn';

  // late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1), // Animation duration
    // );

    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Timer(const Duration(seconds: 1), () {
    //   _controller.forward();
    // });

    // Timer(const Duration(seconds: 3), () {
      // Get.offAll(() => PilotLogin());
      whereToGo();
    // });

    // whereToGo();
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Constant.width * 1, // Using Get.width instead of double.infinity
        height: Constant.height * 1, // Using Get.height instead of double.infinity
        decoration: const BoxDecoration(color: Constant.textBtnColor),
        child: Center(
          child: Text(
            'ORANGE-YATRI',
            style: TextStyle(
                fontSize: Constant.width * .1,
                color: Colors.white, // Changed text color to white
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    var pref = await SharedPreferences.getInstance();
    try {
  var isLoggedIn = pref.getBool(KEYLOGINPERSIST);
  debugPrint("isLoggedIn: $isLoggedIn");
  if (isLoggedIn != null) {
    if (isLoggedIn) {
      Get.offAll(() => const PilotHomePage());
    }else {
    Get.offAll(() => const PilotLogin());

    }
  } else {
    Get.offAll(() => const PilotLogin());
  }
} on Exception catch (e) {
  debugPrint("isLoggedIn error: $e");
  // TODO
}
  }
}
