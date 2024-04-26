import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:orange_yatri/components/authentication/auth_data/register_data.dart';
import 'package:orange_yatri/components/authentication/login_page.dart';
import 'package:orange_yatri/components/authentication/verify_email_address_page.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/ui/ui_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool value = false;
  var err = '';

  RegisterData controller = Get.put(RegisterData());

  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  /// API Calling Function
  void Register(String name, organizationName, gstNumber, mobileNumber, email, password) async{
    var userData = {
      'name': name,
      'organisation': organizationName,
      'gst': gstNumber,
      'email': email,
      'phone': mobileNumber,
      'password': password

    };

    final jsonData = json.encode(userData);
    http.Response response;

    try{

      response = await http.post(
          Uri.parse('https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_SignUp'),
          body: jsonData
      );

      var newResponse = json.decode(response.body);

      if(response.statusCode == 200){
        debugPrint('hallo-1');

        if(newResponse['body-json']['statusCode'] == 200){
          debugPrint('hallo-2');
          // setState(() {
            err = '';
          // });
          Get.to(VerifyEmailAddressPage(email: emailController.text.toString(),));
        } else if(newResponse['body-json']['statusCode'] == 400){

          // setState(() {
            err = newResponse['body-json']['body'];
          // });
// 
          debugPrint(newResponse['body-json']['statusCode']);
          debugPrint(newResponse['body-json']['body']);
        }

      }else{
        debugPrint('failed');
      }

    }catch(e){
      debugPrint(e.toString());
      debugPrint('saddam');
    }

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: Constant.height * .06,),

              /// Registration
              const Text('Registration', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),

              /// Create Your New Account
              const Text('Create Your New Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
              SizedBox(height: Constant.height *.05,),

              /// Name ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('NAME', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(nameController, 'Full Name', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Organization Name ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('ORGANIZATION', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(organizationController, 'Organization Name', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// GST ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('GST', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(gstController, 'GST Number', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Mobile Number ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('MOBILE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(mobileController, 'Mobile Number', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Email TextField
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('EMAIL ADDRESS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(emailController, 'Ex. example@gmail.com', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Password TextField
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('PASSWORD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextField(passwordController, 'Password', false),
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


              SizedBox(
                height: Constant.height * .05,
                width: Constant.width * 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    Text(err, style: const TextStyle(fontSize: 18, color: Colors.red),),
                  ],
                ),
              ),

              /// Check Box and I Agree all Term & Condition
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //           height: Constant.height * .05,
          //           width: Constant.width * .415,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Checkbox(
          //                 value: this.value,
          //                 activeColor: Colors.green,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(2),
          //                 ),
          //                 onChanged: (bool? value) {
          //                   setState(() {
          //                   this.value = value!;
          //                 });
          //             },
          //           ),
          //           Text('Remember me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
          //         ],
          //       ),
          //     ),
          //     UiHelper.customTextButton(() {
          //
          //     }, 'Terms & Condition')
          //   ],
          // ),

              // SizedBox(
              //   height: Constant.height * .02,
              // ),
              /// Register Account Button
              UiHelper.customButton(() {
                // Get.to(HomePage());
                /// Function Calling
                Register(
                  nameController.text.toString(),
                  organizationController.text.toString(),
                  gstController.text.toString(),
                  mobileController.text.toString(),
                  emailController.text.toString(),
                  passwordController.text.toString()
                );
              }, 'Register Account'),

              /// Already have an Account and Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
                  UiHelper.customTextButton(() {
                    Get.to(const LoginPage());
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


