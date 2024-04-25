import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/components/authentication/register_page.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/ui/ui_helper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool value = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Constant.height * .15,
              ),
              /// Text "Login"
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),

              /// Text "Welcome Back To Account"
              const Text(
                'Welcome Back To Account',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Constant.textColor),
              ),

              SizedBox(
                height: Constant.height * .07,
              ),

              /// E-mail Address
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Padding(
                   padding: EdgeInsets.only(left: 10),
                   child: Text('EMAIL ADDRESS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
                 ),
                 SizedBox(width: Constant.width *.001,)
               ],
             ),
              UiHelper.customTextField(emailController, 'Ex. example@gmail.com', false),
              SizedBox(
                height: Constant.height * .02,
              ),
              /// Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('PASSWORD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              UiHelper.customTextField(passwordController, '', false),
              SizedBox(
                height: Constant.height * .02,
              ),
              // SizedBox(
              //   height: Constant.height * .00,
              // ),

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
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),
                        const Text('Remember me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
                      ],
                    ),
                  ),
                  UiHelper.customTextButton(() {

                  }, 'Forget Password')
                ],
              ),

              SizedBox(
                height: Constant.height * .02,
              ),
              /// Login Button
              UiHelper.customButton(() {

              }, 'Login'),
              SizedBox(height: Constant.height * .01,),
              /// Dont have an account and Register Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
                  UiHelper.customTextButton(() {
                    Get.to(const RegisterPage());
                  }, 'Register now'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
