import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/common/db/localData.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_authentication/pilot_registration.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_home_page.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class PilotLogin extends StatefulWidget {
  const PilotLogin({super.key});

  @override
  State<PilotLogin> createState() => PilotLoginState();
}

class PilotLoginState extends State<PilotLogin> {
  bool value = true;
  bool hidePassword = true;
  IconData iconData = Icons.remove_red_eye;
final _formKey = GlobalKey<FormState>();
  TextEditingController dlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void pilotLoginMethod(BuildContext context,String dlNumber, password) async {
    if (dlNumber == '' || password == '') {
      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: 'Fill Required Field',
            backgroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 25, color: Constant.textBtnColor, fontWeight: FontWeight.w600),
          ),
          displayDuration: const Duration(seconds: 2));
    } else {
      var userData = {'dlNumber': dlNumber, 'password': password};

      final jsonData = json.encode(userData);
      http.Response response;

      try {
        response = await http.post(
            Uri.parse('https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_login'),
            body: jsonData);

        var newResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          debugPrint('hallo-1');

          if (newResponse['body-json']['statusCode'] == 200) {
            debugPrint('hallo-2');

            // showTopSnackBar(
            //     Overlay.of(context),
            //     const CustomSnackBar.info(
            //       message: 'Loged in successfully',
            //       backgroundColor: Colors.green,
            //       textStyle: TextStyle(fontSize: 25, color: Constant.textBtnColor, fontWeight: FontWeight.w600),
            //     ),
            //     displayDuration: const Duration(seconds: 2));

            storeDLNumber(dlNumber);

            storeToken(newResponse['body-json']['body']['tokens']);

            var pref = await SharedPreferences.getInstance();
            pref.setBool(LocalDb.KEYLOGINPERSIST, true);
            Get.offAll(const PilotHomePage());
          } else if (newResponse['body-json']['statusCode'] == 400) {
            debugPrint('hallo-3');

            // showTopSnackBar(
            //     Overlay.of(context),
            //     CustomSnackBar.info(
            //       message: newResponse['body-json']['body'],
            //       backgroundColor: Colors.white,
            //       textStyle: const TextStyle(fontSize: 25, color: Constant.textBtnColor, fontWeight: FontWeight.w600),
            //     ),
            //     displayDuration: const Duration(seconds: 3));

            debugPrint(newResponse['body-json']['body']);
          } else {
            // showTopSnackBar(
            //     Overlay.of(context),
            //     const CustomSnackBar.info(
            //       message: 'Please Enter Correct Password',
            //       backgroundColor: Colors.white,
            //       textStyle: TextStyle(fontSize: 25, color: Constant.textBtnColor, fontWeight: FontWeight.w600),
            //     ),
            //     displayDuration: const Duration(seconds: 3));
          }
        } else {
          debugPrint('hallo-4');
          debugPrint('Failed');

          // showTopSnackBar(
          //     Overlay.of(context),
          //     const CustomSnackBar.info(
          //       message: 'Failed',
          //       backgroundColor: Colors.white,
          //       textStyle: TextStyle(fontSize: 25, color: Constant.textBtnColor, fontWeight: FontWeight.w600),
          //     ),
          //     displayDuration: const Duration(seconds: 2));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Constant.height * 1,
        width: Constant.width * 1,
        child: Stack(
          children: [
            /// Back Image Container
            Container(
              height: Constant.height * .35,
              width: Constant.width * 1,
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(image: AssetImage('assets/images/truck image.jpg'), fit: BoxFit.cover),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'PopinsBlack'),
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'PopinsBlack'),
                  )
                ],
              ),
            ),

            /// box 2
            Container(
              height: Constant.height * .7,
              width: Constant.width * 1,
              margin: EdgeInsets.only(top: Constant.height * .3),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.elliptical(500, 100), topRight: Radius.elliptical(500, 100))),
            ),

            /// Main Content
            Container(
              height: Constant.height * 7,
              padding: const EdgeInsets.all(16),
              width: Constant.width * 1,
              margin: EdgeInsets.only(top: Constant.height * .3),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Constant.height * .07,
                        ),
                    
                        /// DL Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'DL Number',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Constant.width * .001,
                            )
                          ],
                        ),
                        UiHelper.customTextFieldWithIconAndCharaterSize(
                            dlController, 'Ex. DL1420110012345', false, Icons.drive_eta, 15),
                        SizedBox(
                          height: Constant.height * .02,
                        ),
                    
                        /// Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'PASSWORD',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w600, color: Constant.textBtnColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Constant.width * .001,
                            )
                          ],
                        ),
                        UiHelper.customTextFieldWithIconButton(() {
                          // setState(() {
                            hidePassword = !hidePassword;
                          // });
                        }, passwordController, '', hidePassword,
                            hidePassword == false ? Icons.visibility : Icons.visibility_off),
                        SizedBox(
                          height: Constant.height * .02,
                        ),
                    
                        /// Remember me and forget password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Constant.height * .05,
                              width: Constant.width * .45,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: value,
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    onChanged: (bool? value) {
                                      // setState(() {
                                      //   this.value = value!;
                                      // });
                                    },
                                  ),
                                  const Text(
                                    'Remember me',
                                    style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),
                                  ),
                                ],
                              ),
                            ),
                            UiHelper.customTextButton(() {}, 'Forget Password')
                          ],
                        ),
                    
                        // SizedBox(
                        //   height: Constant.height * .28,
                        // ),
                    
                        SizedBox(
                          height: Constant.height * .07,
                        ),
                    
                        /// Login Button
                        // FutureBuilder(
                        //   future: PilotLoginMethod(dlController.text.toString(),
                        //       passwordController.text.toString()),
                        //   builder: (context, snapshot) {
                        //
                        //     if(snapshot.connectionState == ConnectionState.waiting){
                        //
                        //       return UiHelper.customButtonCPI();
                        //
                        //     }else{
                        //
                        //       return UiHelper.customButton(() {
                        //         PilotLoginMethod(dlController.text.toString(),
                        //             passwordController.text.toString());
                        //       }, 'Login');
                        //
                        //     }
                        //
                        //   },
                        // ),
                    
                        UiHelper.customButton(() {
                          pilotLoginMethod(context, dlController.text.toString(), passwordController.text.toString());
                        }, 'Login'),
                    
                        SizedBox(
                          height: Constant.height * .001,
                        ),
                    
                        /// Dont have an account and Register Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Dont have an account?',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),
                            ),
                            UiHelper.customTextButton(() {
                              Get.to(const PilotRegistration());
                            }, 'Register now'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void storeDLNumber(String dlNumber) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(LocalDb.KEYDLNUMBER, dlNumber);
    debugPrint('dlNumber saved successfully');
  }

  void storeToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(LocalDb.KEYTOKEN, token);
    debugPrint('Token saved successfully');
  }
}
