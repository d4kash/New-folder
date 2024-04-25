import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_home_page.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PilotUpdateProfile extends StatefulWidget {
  const PilotUpdateProfile({super.key});

  @override
  State<PilotUpdateProfile> createState() => _PilotUpdateProfileState();
}

class _PilotUpdateProfileState extends State<PilotUpdateProfile> {

  TextEditingController dlController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void updateProfileData(String dlNumber, mobile, name) async{

    var userData = {
      'dlNumber': dlNumber,
      'name': name,
      'phone': mobile
    };

    var jsonData = json.encode(userData);

    http.Response response;

    try{

      response = await http.put(
        Uri.parse(
          'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_update_pilot_profile'
        ), body: jsonData
      );

      if(response.statusCode == 200){

        var newResponse = json.decode(response.body);

        if(newResponse['body-json']['statusCode'] == 200){

          showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.info(
                message: 'Profile Updated Successfully',
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: const Duration(seconds: 2)
          );

          Get.offAll(const PilotHomePage());

        }else if(newResponse['body-json']['statusCode'] == 400){

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
              displayDuration: const Duration(seconds: 2)
          );

        }

      }else{

        debugPrint('Failed');

      }

    }catch(e){

      debugPrint(e.toString());
      debugPrint('saddam bhai ye Exception hai');

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
                SizedBox(height: Constant.height * .05),
                Text('Update Profile', style: TextStyle(fontSize: Constant.width * .08, fontWeight: FontWeight.w700)),
                SizedBox(height: Constant.height * .05),
                UiHelper.customTextFieldWithLabel(dlController, 'DL Number', false),
                SizedBox(height: Constant.height * .02,),
                UiHelper.customTextFieldWithLabel(nameController, 'Pilot Name', false),
                SizedBox(height: Constant.height * .02,),
                UiHelper.customTextFieldWithLabel(mobileController, 'Mobile', false),


                SizedBox(height: Constant.height * .46,),


                UiHelper.customButton(() {

                  updateProfileData(dlController.text.toString(), mobileController.text.toString(), nameController.text.toString());

                }, 'Update'),
              ]
          )
        ),
      )
    );
  }
}
