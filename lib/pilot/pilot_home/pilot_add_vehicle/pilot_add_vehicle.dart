import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_vehicle/pilot_all_vehicle.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PilotAddVehicle extends StatefulWidget {
  const PilotAddVehicle({super.key});

  @override
  State<PilotAddVehicle> createState() => _PilotAddVehicleState();
}

class _PilotAddVehicleState extends State<PilotAddVehicle> {

  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController chasisNumberController = TextEditingController();
  TextEditingController ownerMobileController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController dlNumberController = TextEditingController();

  void pilotAddVehicleDetails(String vehicleName, vehicleNumber, engineNumber,
      chasisNumber, ownerMobile, ownerName, dlNumber) async {

    if(vehicleName == '' || vehicleNumber == '' || engineNumber == '' || chasisNumber == ''  || ownerMobile == '' || ownerName == '' || dlNumber == ''){

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
        'vehicleName': vehicleName,
        'vehicleNumber': vehicleNumber,
        'engineNumber': engineNumber,
        'chasisNumber': chasisNumber,
        'ownerPhone': ownerMobile,
        'ownerName': ownerName,
        'dlNumber': dlNumber
      };

      final jsonData = json.encode(userData);
      http.Response response;

      try {
        response = await http.post(
            Uri.parse(
                'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_add_vehicle'),
            body: jsonData);

        var newResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          debugPrint('hallo-1');

          if (newResponse['body-json']['statusCode'] == 200) {
            debugPrint('hallo-2');

            showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'Vehicle Added successfully',
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Constant.textBtnColor,
                      fontWeight: FontWeight.w600),
                ),
                displayDuration: const Duration(seconds: 2)
            );

            Get.off(const PilotAllVehicle());
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
                height: Constant.height * .06,
              ),

              /// Add Vehicle ( Heading Text )
              const Text(
                'Add Vehicle',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),

              SizedBox(
                height: Constant.height * .04,
              ),

              UiHelper.customTextFieldWithLabel(
                  vehicleNameController, 'Vehicle Name', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(
                  vehicleNumberController, 'Vehicle Number', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(
                  engineNumberController, 'Engine Number', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(
                  chasisNumberController, 'Chasis Number', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(
                  ownerMobileController, 'Owner Mobile', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(
                  ownerNameController, 'Owner Name', false),

              SizedBox(
                height: Constant.height * .02,
              ),

              UiHelper.customTextFieldWithLabel(dlNumberController, 'DL Number', false),

              SizedBox(
                height: Constant.height * .02,
              ),


              SizedBox(
                height: Constant.height * .06,
              ),


              UiHelper.customButton(() {
                pilotAddVehicleDetails(
                    vehicleNameController.text.toString(),
                    vehicleNumberController.text.toString(),
                    engineNumberController.text.toString(),
                    chasisNumberController.text.toString(),
                    ownerMobileController.text.toString(),
                    ownerNameController.text.toString(),
                    dlNumberController.text.toString());
              }, 'submit')
            ],
          ),
        ),
      ),
    );
  }
}
