import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_authentication/Pilot_verify_email.dart';
import 'package:orange_yatri/pilot/pilot_authentication/pilot_login.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PilotRegistration extends StatefulWidget {
  const PilotRegistration({super.key});

  @override
  State<PilotRegistration> createState() => _PilotRegistrationState();
}

class _PilotRegistrationState extends State<PilotRegistration> {
  bool value = true;
  bool hidePassword = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController dlController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void pilotSignup(String name, mobileNumber, email, password, dlNumber) async {

    if(name == '' || mobileNumber == '' || dlNumber == '' || password == ''){

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: 'Fill Required Field',
            backgroundColor: Colors.white,
            textStyle: TextStyle(
                fontSize: 25,
                color: Constant.textBtnColor,
                fontWeight: FontWeight.w600),
          ),
          displayDuration: const Duration(seconds: 2)
      );

    }else{

      var userData = {
        'name': name,
        'email': email,
        'phone': mobileNumber,
        'password': password,
        'dlNumber': dlNumber
      };

      final jsonData = json.encode(userData);
      http.Response response;

      try {
        response = await http.post(
            Uri.parse(
                'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_signUp'),
            body: jsonData);

        var newResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          debugPrint('hallo-1');

          if (newResponse['body-json']['statusCode'] == 200) {
            debugPrint('hallo-2');

            if(email == ''){

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
                  displayDuration: const Duration(seconds: 2)
              );

              Get.offAll(const PilotLogin());

            }else{

              Get.to(PilotVerifyEmail(email: email));

            }
          } else if (newResponse['body-json']['statusCode'] == 400) {

            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(
                  message: newResponse['body-json']['body'],
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 25,
                      color: Constant.textBtnColor,
                      fontWeight: FontWeight.w600),
                ),
                displayDuration: const Duration(seconds: 3)
            );

            debugPrint(newResponse['body-json']['statusCode']);
            debugPrint(newResponse['body-json']['body']);
          }
        } else {
          debugPrint('failed');
        }
      } catch (e) {
        debugPrint(e.toString());
        debugPrint('saddam');
      }

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
                height: Constant.height * .04,
              ),

              /// Registration
              const Text(
                'Register As Pilot',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),

              /// Create Your New Account
              // Text('Create Your New Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Name ( TextField )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('Name', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),),
                        Text('*', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),),
                      ],
                    ),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextFieldWithIcon(nameController, 'Full Name', false, Icons.person),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// GST ( TextField )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('DL Number', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),),
                        Text('*', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),),
                      ],
                    ),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextFieldWithIconAndCharaterSize(dlController, 'DL Number', false, Icons.drive_eta, 15),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Mobile Number ( TextField )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('Mobile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),),
                        Text('*', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),),
                      ],
                    ),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextFieldWithIcon(
                  mobileController, 'Mobile Number', false, Icons.phone_android),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Email TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('Email', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),),
                        Text('', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),),
                      ],
                    ),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextFieldWithIcon(
                  emailController, 'Ex. example@gmail.com', false, Icons.mail_outline),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Password TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('Password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),),
                        Text('*', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),),
                      ],
                    ),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextFieldWithIconButton(() {
                  setState(() {
                    hidePassword = hidePassword ? false : true;
                  });
              },passwordController, 'Password', hidePassword, Icons.remove_red_eye_outlined),
              // SizedBox(
              //   height: Constant.height * .02,
              // ),

              // Container(
              //   height: Constant.height * .05,
              //   width: Constant.width * 1,
              //   child: Obx(() {
              //     return Text(err, style: TextStyle(fontSize: 18, color: Colors.red),);
              //   }),
              // ),

              /// Check Box and I Agree all Term & Condition
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constant.height * .05,
                    // width: Constant.width * .415,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: value,
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Constant.textColor),
                        ),
                      ],
                    ),
                  ),
                  UiHelper.customTextButton(() {}, 'Terms & Condition')
                ],
              ),

              /// Response Message Box
              SizedBox(
                height: Constant.height * .04,
              ),


              /// Register Account Button
              UiHelper.customButton(() {
                /// Function Calling
                pilotSignup(
                    nameController.text.toString(),
                    mobileController.text.toString(),
                    emailController.text.toString(),
                    passwordController.text.toString(),
                    dlController.text.toString());
              }, 'Register Account'),

              /// Already have an Account and Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Constant.textColor),
                  ),
                  UiHelper.customTextButton(() {
                    Get.to(const PilotLogin());
                  }, 'Login now'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
