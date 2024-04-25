import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:http/http.dart' as http;
import 'package:orange_yatri/pilot/pilot_authentication/pilot_login.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../ui/ui_helper.dart';

class PilotVerifyEmail extends StatefulWidget {
  final String email;
  const PilotVerifyEmail({super.key, required this.email});

  @override
  State<PilotVerifyEmail> createState() => _PilotVerifyEmailState();
}

class _PilotVerifyEmailState extends State<PilotVerifyEmail> {
  TextEditingController pinputController = TextEditingController();

  void VerifyOtp(String email, String otp) async {
    var userData = {'email': email, 'otp': int.parse(otp)};

    final jsonData = json.encode(userData);
    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_verify_signUp'),
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        debugPrint('hallo-1');

        if (newResponse['body-json']['statusCode'] == 200) {
          debugPrint('hallo-2');
          // setState(() {
          //   err = '';
          // });

          showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.info(
                message: 'Registered successfully',
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: const Duration(seconds: 2));

          Get.offAll(const PilotLogin());
        } else if (newResponse['body-json']['statusCode'] == 400) {
          showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.info(
                message: newResponse['body-json']['body'],
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: const Duration(seconds: 2));

          debugPrint(newResponse['body-json']['statusCode']);
          debugPrint(newResponse['body-json']['body']);
        }
      } else {
        debugPrint('failed');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Constant.height * .1,
              ),

              /// Verify Email Address
              const Text(
                'Verify Email Address',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              ),

              /// Waiting for OTP
              const Text(
                'Waiting for OTP',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Constant.textColor),
              ),

              SizedBox(
                height: Constant.height * .05,
              ),

              SizedBox(
                height: Constant.height * .05,
              ),

              /// Description
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('A 4 digit code has been to your registered', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Constant.textColor),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(' Email ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Constant.textColor),),
                      Text(widget.email, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black45),),
                    ],
                  ),
                  const Text('for verification purpose', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Constant.textColor),),
                ],
              ),

              SizedBox(
                height: Constant.height * .08,
              ),

              /// OTP Boxes
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     UiHelper.customOtpBox(otpController1),
              //     UiHelper.customOtpBox(otpController2),
              //     UiHelper.customOtpBox(otpController3),
              //     UiHelper.customOtpBox(otpController4),
              //   ],
              // ),

              UiHelper.customOtpBox(pinputController),

              /// Sized Box
              // SizedBox(
              //   height: Constant.height * .26,
              // ),

              SizedBox(
                height: Constant.height * .26,
                width: Constant.width * 1,
                //child: Center(child: Text(err, style:  TextStyle(fontSize: 18, color: Colors.red),)),
              ),

              /// Confirm Registration Button
              UiHelper.customButton(() {
                //Get.to(RegistrationCompletedPage());
                VerifyOtp(widget.email, pinputController.text.toString());
              }, 'Confirm Registration'),

              /// Did not recieve code ? Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Did not recieve code ? ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Constant.textColor),
                  ),
                  UiHelper.customTextButton(() {}, 'Resend Code'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
