import 'package:flutter/material.dart';
import 'package:orange_yatri/constant/constant_color.dart';


class RegistrationCompletedPage extends StatefulWidget {
  const RegistrationCompletedPage({super.key});

  @override
  State<RegistrationCompletedPage> createState() => _RegistrationCompletedPageState();
}

class _RegistrationCompletedPageState extends State<RegistrationCompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Constant.height * .25,
              ),
              /// Right Tick Circle
              Container(
                height: Constant.height * .3,
                width: Constant.width * .6,
                decoration: BoxDecoration(
                  color: Constant.textBtnColor,
                  borderRadius: BorderRadius.circular(200),
                ),
              ),

              SizedBox(
                height: Constant.height * .02,
              ),
              /// Registration Completed
              const Text('Registration Completed', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),

              SizedBox(
                height: Constant.height * .02,
              ),

              /// Description
              const Column(
                children: [
                  Text('Lorem ipsum dolor sit amet consectetur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
                  Text('adipsicing elit. Quo Lorem ipsum dolor sit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
                  Text('amet consectetur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
                ],
              )
            ]
          )
        ),
        onTap: () {
          // Get.to(PilotProfilePage());
        },
      )
    );
  }
}
